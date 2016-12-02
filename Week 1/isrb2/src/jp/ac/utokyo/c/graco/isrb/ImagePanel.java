/*******************************************************************************
 * Copyright (c) 2012 Hidehiko Masuhara.
 * All rights reserved. This program and the accompanying materials
 * are made available under the terms of the GNU Public License v3.0
 * which accompanies this distribution, and is available at
 * http://www.gnu.org/licenses/gpl.html
 * 
 * Contributors:
 *     Hidehiko Masuhara - initial API and implementation
 *     
 * $Id: ImagePanel.java,v 1.7 2012/09/14 05:06:45 masuhara Exp $
 ******************************************************************************/
package jp.ac.utokyo.c.graco.isrb;

import java.awt.Color;
import java.awt.Component;
import java.awt.Frame;
import java.awt.Graphics;
import java.awt.Window;
import java.awt.event.ActionEvent;
import java.awt.event.KeyEvent;
import java.awt.event.MouseAdapter;
import java.awt.event.MouseEvent;
import java.awt.image.BufferedImage;
import java.awt.image.DataBufferInt;
import java.io.File;
import java.io.IOException;
import java.util.Vector;

import javax.imageio.ImageIO;
import javax.swing.AbstractAction;
import javax.swing.JFileChooser;
import javax.swing.JFrame;
import javax.swing.JMenuItem;
import javax.swing.JOptionPane;
import javax.swing.JPanel;
import javax.swing.JPopupMenu;
import javax.swing.KeyStroke;
import javax.swing.filechooser.FileNameExtensionFilter;

@SuppressWarnings("serial")
public class ImagePanel extends JPanel {
	private static final int FRAME_WIDTH = 500;
	private static final int FRAME_HEIGHT = 500;
	private int imageWidth = 0;
	private int imageHeight = 0;
	private BufferedImage img;
	private Vector<BufferedImage> frames = new Vector<BufferedImage>();
	private boolean playing;
	protected int currentFrame;
	private ImageFrameAction playOrStopAction;
	private int[] pixelData;

	abstract class ImageFrameAction extends AbstractAction {
		ImageFrameAction(int mnemonicKey, KeyStroke acceleratorKey,
				String actionName, boolean enabled) {
			super(actionName);
			this.putValue(AbstractAction.MNEMONIC_KEY, mnemonicKey);
			this.putValue(AbstractAction.ACCELERATOR_KEY, acceleratorKey);
			this.setEnabled(enabled);
			ImagePanel.this.getActionMap().put(actionName, this);
			ImagePanel.this.getInputMap().put(acceleratorKey, actionName);
		}

	}

	public Window getEnclosingFrame() {
		Component f = ImagePanel.this;
		while (!(f instanceof Window))
			f = f.getParent();
		return (Window) f;
	}

	private ImagePanel() {
		playOrStopAction = new ImageFrameAction(KeyEvent.VK_A,
				KeyStroke.getKeyStroke(KeyEvent.VK_A, KeyEvent.CTRL_MASK),
				"Start/Stop animation", false) {//disabled at first
			@Override
			public void actionPerformed(ActionEvent e) {
				playOrStop();
			}
		};

		AbstractAction saveAsAction = new ImageFrameAction(KeyEvent.VK_S,
				KeyStroke.getKeyStroke(KeyEvent.VK_S, KeyEvent.CTRL_MASK),
				"Save Image as...", true) {
			@Override
			public void actionPerformed(ActionEvent e) {
				saveImageAs();
			}
		};

		AbstractAction closeAction = new ImageFrameAction(KeyEvent.VK_C,
				KeyStroke.getKeyStroke(KeyEvent.VK_W, KeyEvent.CTRL_MASK),
				"Close", true) {
			@Override
			public void actionPerformed(ActionEvent e) {
				getEnclosingFrame().dispose();
			}
		};

		final JPopupMenu popup = new JPopupMenu();
		JMenuItem playOrStopItem = new JMenuItem(playOrStopAction);
		JMenuItem closeWindowItem = new JMenuItem(closeAction);
		JMenuItem saveImageAsItem = new JMenuItem(saveAsAction);
		popup.add(playOrStopItem);
		popup.add(saveImageAsItem);
		popup.add(closeWindowItem);
		setComponentPopupMenu(popup);

		// to show the pop-up menu even with a click of the left-button
		// (setComponentPopupMenu will make the menu appearing with
		// right-clicking, but I'd like to show it with a left-click as well.)
		addMouseListener(new MouseAdapter() {
			@Override
			public void mouseReleased(MouseEvent e) {show(e);}
			@Override
			public void mousePressed(MouseEvent e) {show(e);}
			private void show(MouseEvent e) {
				popup.show(e.getComponent(), e.getX(), e.getY());
			}
		});

	}

	// TODO: show play button when animation is possible
	// TODO: spreadsheet view

	public void saveImageAs() {
		try {
			File f = askFileName();
			if (f != null) {
				String name = f.toString();
				String ext = name.substring(name.indexOf('.', 0) + 1);
				ImageIO.write(img, ext, f);
			}
		} catch (IOException e) {
			System.err.println(e);
			e.printStackTrace();
		}

	}

	private File askFileName() {
		JFileChooser chooser = new JFileChooser();
		// TODO remember the directory lastly chosen, and set that as its
		// default
		chooser.setAcceptAllFileFilterUsed(false);
		chooser.addChoosableFileFilter(new FileNameExtensionFilter(
				"PNG format", "png", "PNG"));
		chooser.addChoosableFileFilter(new FileNameExtensionFilter(
				"JPEG format", "jpg", "JPG", "jpeg", "JPEG"));
		chooser.setSelectedFile(defaultFileNameToSave(chooser
				.getCurrentDirectory()));
		int returnVal = chooser.showSaveDialog(getParent());
		File f = returnVal == JFileChooser.APPROVE_OPTION ? chooser
				.getSelectedFile() : null;
		return f;
	}

	private File defaultFileNameToSave(File directory) {
		String base = "image";
		String ext = ".png";
		int counter = 0;
		File f = new File(directory, base + ext);
		while (f.exists())
			f = new File(directory, base + (counter++) + ext);
		return f;
	}

	@Override
	public void paint(Graphics g) {

		g.setColor(Color.blue);
		g.fillRect(0, 0, getWidth(), getHeight());// TODO do only when the frame
													// is resized
		BufferedImage imageToShow = getImage();
		if (imageToShow == null)
			return;
		int frameWidth = getWidth(); // Since the panel might be resized after
		int frameHeight = getHeight();// creation, we obtain actual size
		int scale = Math.max(
				1,
				Math.min((frameWidth - 50) / imageWidth, (frameHeight - 50)
						/ imageHeight));
		int dx1 = (frameWidth - (imageWidth * scale)) / 2;
		int dy1 = (frameHeight - (imageHeight * scale)) / 2;
		int dx2 = dx1 + imageWidth * scale;
		int dy2 = dy1 + imageHeight * scale;
		g.drawImage(imageToShow, dx1, dy1, dx2, dy2, 0, 0, imageWidth,
				imageHeight, null);

	}

	private BufferedImage getImage() {
		return playing ? frames.get(currentFrame) : img;
	}

	private void prepareImage(int w, int h) {
		if (img == null) {
			imageWidth = w;
			imageHeight = h;
			img = new BufferedImage(imageWidth, imageHeight,
					BufferedImage.TYPE_INT_RGB);
//			frames.add(img);
			pixelData = ((DataBufferInt)img.getRaster().getDataBuffer()).getData();
		} 
	}

	private void recordImage() {
		BufferedImage savedImage = new BufferedImage(imageWidth,
				imageHeight, BufferedImage.TYPE_INT_RGB);
		savedImage.setData(img.copyData(null));
		frames.add(savedImage);
		if (frames.size()>=2) 
			playOrStopAction.setEnabled(true);
	}

	public void showGray(double[][] a) {
		showGrayWithDataBuffer(a);
	}
	
//	private void showGrayWithGraphics(double[][] a) {
//		Graphics g = prepareImage(a[0].length, a.length);
//		for (int y = 0; y < a.length; y++)
//			for (int x = 0; x < a[y].length; x++) {
//				double intensity = a[y][x];
//				g.setColor(new Color(normalize8bit(intensity),normalize8bit(intensity),normalize8bit(intensity)));
//				g.fillRect(x, y, 1, 1);
//			}
//		repaint();
//	}
	private void showGrayWithDataBuffer(double[][] a) {
		prepareImage(a[0].length, a.length);
		for (int y = 0; y < Math.min(imageHeight, a.length); y++)
			for (int x = 0; x < Math.min(imageWidth, a[y].length); x++) {
				int intensity = normalize8bit(a[y][x]);
				pixelData[y*imageWidth + x] = (intensity<<16) | (intensity<<8) | intensity; 
			}
		
		repaint();
		recordImage();
	}

	public void showColor(double[][][] a) {
//		showColorWithGraphics(a);//13.7 secs
		showColorWithDataBuffer(a);//10.0 secs
	}
//	private void showColorWithGraphics(double[][][] a) {
//		Graphics graphics = prepareImage(a[0].length, a.length);
//		for (int y = 0; y < a.length; y++)
//			for (int x = 0; x < a[y].length; x++) {
//				int r = normalize8bit(a[y][x][0]);
//				int g = normalize8bit(a[y][x][1]);
//				int b = normalize8bit(a[y][x][2]);
//				graphics.setColor(new Color(r, g, b));
//				graphics.fillRect(x, y, 1, 1);
//			}
//		repaint();
//
//	}
	private void showColorWithDataBuffer(double[][][] a) {
		prepareImage(a[0].length, a.length);
		pixelData = ((DataBufferInt)img.getRaster().getDataBuffer()).getData();
		try { 
			storeColorImageFast(a, pixelData); 
		} catch (ArrayIndexOutOfBoundsException e) 
		{ storeColorImageSafe(a, pixelData); }
		repaint();
		recordImage();

	}

	private void storeColorImageFast(double[][][] a, int[] pixelData) {
		for (int y = 0; y < Math.min(imageHeight, a.length); y++)
			for (int x = 0; x < Math.min(imageWidth, a[y].length); x++) {
				int r=0,g=0,b=0;
				r = normalize8bit(a[y][x][0]);
				g = normalize8bit(a[y][x][1]);
				b = normalize8bit(a[y][x][2]);
				pixelData[y*imageWidth + x] = (r<<16) | (g<<8) | b; 
			}
	}
	private void storeColorImageSafe(double[][][] a, int[] pixelData) {
		for (int y = 0; y < Math.min(imageHeight, a.length); y++)
			for (int x = 0; x < Math.min(imageWidth, a[y].length); x++) {
				int r=0,g=0,b=0;
				try {
					r = normalize8bit(a[y][x][0]);
					g = normalize8bit(a[y][x][1]);
					b = normalize8bit(a[y][x][2]);
				} catch (ArrayIndexOutOfBoundsException e) { ; }
				pixelData[y*imageWidth + x] = (r<<16) | (g<<8) | b; 
			}
	}

	private final int normalize8bit(final double intensity) {
		//1: without normalization
//		return (int) (intensity*255);
		//2: with normalization
		return Math.max(0, Math.min(255, (int) (intensity * 255)));
		//Benchmark tests of drawing ten 400x400 images:
		//1: 5.8 secs
		//2: 5.6 secs
	}
	
	public void updatePixel(int x, int y, double r, double g, double b) {
		int rint = normalize8bit(r);
		int gint = normalize8bit(g);
		int bint = normalize8bit(b);
		pixelData[y*imageWidth+x] = (rint<<16) | (gint<<8) | bint; 
		repaint();
	}

	public synchronized void playOrStop() {
		if (playing)
			playing = false;
		else
			play();
	}

	// to start animation
	private void play() {
		playing = true;// TODO thread safety
		new Thread() {
			@Override
			public void run() {
				currentFrame = 0; // Since the first element in the frames
									// contains the latest image, we start
									// animation from index 1, which should
									// contain the oldest shown image.
				Window w = getEnclosingFrame();
				// stop animation when w is disposed
				int interval = Math.max(1000/30, 1000/frames.size());
				while (playing && w.isDisplayable()) {
					try {
						Thread.sleep(interval);
						currentFrame = (currentFrame + 1) % frames.size();
						repaint();
					} catch (InterruptedException e) {
						e.printStackTrace();
					}

				}
			}

		}.start();
	}

	public static ImagePanel createFrame() throws InterruptedException {
		final JFrame f = new JFrame("isrb");
		f.setSize(FRAME_WIDTH, FRAME_HEIGHT);
		// to allow the VM terminate after the last frame is closed. (Otherwise,
		// the VM may not terminate even if all the frames are closed and the
		// main thread is stopped.)
		f.setDefaultCloseOperation(JFrame.DISPOSE_ON_CLOSE);
		ImagePanel imagePanel = new ImagePanel();
		f.getContentPane().add(imagePanel);

		f.validate();
		f.setVisible(true);
		return imagePanel;
	}
	
	public static void atExit() {
		Frame[] fs = JFrame.getFrames();
		boolean existsVisibleFrame = false;
		for (Frame f : fs)
			existsVisibleFrame = existsVisibleFrame || f.isVisible();
		if (existsVisibleFrame) {
			JOptionPane.showMessageDialog(null, "isrb: all windows will be closed.");
			closeAll();
		}
	}
	
	public static void closeAll() {
		for (Frame f : JFrame.getFrames()) 
			f.dispose();
	}
}

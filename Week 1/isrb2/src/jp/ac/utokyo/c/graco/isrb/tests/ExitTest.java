package jp.ac.utokyo.c.graco.isrb.tests;

import java.awt.Frame;

import javax.swing.JFrame;

import jp.ac.utokyo.c.graco.isrb.ImagePanel;

public class ExitTest {

	/**
	 * @param args
	 * @throws InterruptedException 
	 */
	public static void main(String[] args) throws InterruptedException {
		test1();

		test2();
	}

	private static void test1() throws InterruptedException, Error {
		ImagePanel f1 = ImagePanel.createFrame();
		f1.showGray(new double[][]{{0,1},{1,0}});
		ImagePanel f2 = ImagePanel.createFrame();
		f2.showGray(new double[][]{{0,1},{1,0}});
		ImagePanel.atExit(); // shows a dialog, and closes
		
		if (f1.isDisplayable() || f2.isDisplayable())
			throw new Error("windows are not closed");
	}

	private static void test2() throws InterruptedException, Error {
		ImagePanel f1 = ImagePanel.createFrame();
		f1.showGray(new double[][]{{0,1},{1,0}});
		ImagePanel f2 = ImagePanel.createFrame();
		f2.showGray(new double[][]{{0,1},{1,0}});
		f1.getEnclosingFrame().dispose();
		f2.getEnclosingFrame().dispose();
		ImagePanel.atExit(); // shows a dialog, and closes
		
	}

}

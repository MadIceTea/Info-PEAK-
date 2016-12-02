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
 * $Id: ImageFrameTest.java,v 1.2 2012/09/05 03:09:38 masuhara Exp $
 ******************************************************************************/
package jp.ac.utokyo.c.graco.isrb.tests;

import jp.ac.utokyo.c.graco.isrb.ImagePanel;


public class ImageFrameTest {

	/**
	 * @param args
	 * @throws InterruptedException 
	 */
	public static void main(String[] args) throws InterruptedException {
		ImagePanel f = ImagePanel.createFrame();
		f.showGray(new double[][]{{0,1},{1,0}});
		Thread.sleep(1000);
		f.updatePixel(0, 0, 1, 0, 1);
		Thread.sleep(1000);
		bigImage(ImagePanel.createFrame());
		Thread.sleep(1000);
		grayImage(ImagePanel.createFrame());
		Thread.sleep(1000);
		colorImage(ImagePanel.createFrame());
		Thread.sleep(1000);
		nonSquare(ImagePanel.createFrame());
	}

	private static void bigImage(ImagePanel f) {
		double[][] a = new double[400][400];
		
		for (int y=0; y < a.length; y++)
			for (int x=0; x < a[y].length; x++)
				a[y][x] = g(a.length,x,y);
		f.showGray(a);
	}

	private static int g(int size, int x, int y) {
		final int halfSize = size/2;
		final int dx = x-halfSize;
		final int dy = y-halfSize;
		int d = dx*dx + dy*dy;
		return d > halfSize*halfSize ? 0 : 1;
	}

	private static void grayImage(ImagePanel f) {
		double[][] a = new double[400][400];
		
		for (int y=0; y < a.length; y++)
			for (int x=0; x < a[y].length; x++)
				a[y][x] = h(a.length,x,y);
		f.showGray(a);
	}

	private static double h(int size, int x, int y) {
		final int halfSize = size/2;
		final int dx = x-halfSize;
		final int dy = y-halfSize;
		double d = Math.sqrt(dx*dx + dy*dy);
		return d > halfSize ? 0 : d/halfSize;
	}

	private static void colorImage(ImagePanel f) {
		double[][][] a = new double[400][400][3];
		
		for (int y=0; y < a.length; y++)
			for (int x=0; x < a[y].length; x++)
				k(a.length,x,y, a[y][x]);
		f.showColor(a);
	}

	private static void k(int length, int x, int y, double[] rgb) {
		double r = y*1.0/length;
		double g = x*1.0/length;
		final int halfSize = length/2;
		final int dx = x-halfSize;
		final int dy = y-halfSize;
		double d = Math.sqrt(dx*dx + dy*dy);
		double b = d/halfSize;
		rgb[0] = r;
		rgb[1] = g;
		rgb[2] = b;
	}

	private static void nonSquare(ImagePanel f) {
		double[][] a = new double[1][5];
		for (int x=0; x < a[0].length; x++)
			a[0][x] = (x*1.0/a[0].length);
		f.showGray(a);
		
	}

}

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
 * $Id: ImageWriteTest.java,v 1.2 2012/09/05 03:09:38 masuhara Exp $
 ******************************************************************************/
package jp.ac.utokyo.c.graco.isrb.tests;

import jp.ac.utokyo.c.graco.isrb.ImagePanel;

public class ImageWriteTest {
	/**
	 * @param args
	 * @throws InterruptedException 
	 */
	public static void main(String[] args) throws InterruptedException {
		ImagePanel f = ImagePanel.createFrame();
		colorImage(f);
		f.saveImageAs();
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

}

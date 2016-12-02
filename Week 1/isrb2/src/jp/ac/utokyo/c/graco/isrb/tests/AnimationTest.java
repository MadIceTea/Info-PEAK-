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
 * $Id: AnimationTest.java,v 1.2 2012/09/05 03:09:38 masuhara Exp $
 ******************************************************************************/
package jp.ac.utokyo.c.graco.isrb.tests;

import jp.ac.utokyo.c.graco.isrb.ImagePanel;


public class AnimationTest {

	/**
	 * @param args
	 * @throws InterruptedException 
	 */
	public static void main(String[] args) throws InterruptedException {
		showOneImage();
		showTwoImages();
		createAndPlayTest();
	}

	private static void showOneImage() throws InterruptedException {
		ImagePanel f = ImagePanel.createFrame();
		f.showGray(new double[][] {{0,1}, {1,0}});
	}

	private static void showTwoImages() throws InterruptedException {
		ImagePanel g = ImagePanel.createFrame();
		double [][] a= new double[][] {{0}};
		g.showGray(a);
		a[0][0]=1;
		g.showGray(a);
	}

	private static void createAndPlayTest() throws InterruptedException {
		ImagePanel f = ImagePanel.createFrame();
		int size = 400;
		createImage(f, size);
		f.playOrStop();
	}

	private static void createImage(ImagePanel f, int size) {
		int frames = 30;
		double[][] image = new double[size][size];
		for (int i=0; i < frames; i++) {
			ripple(image, size, i*2*Math.PI/30);
			f.showGray(image);
//			Thread.sleep(1000/30);
		}
	}

	private static void ripple(double[][] image, int size, double theta) {
		for (int y=0; y<size; y++)
			for (int x=0; x<size; x++) {
				double d = Math.sqrt(square(y-size/2.0) +square(x-size/2.0));
				double b = 0.5 * (Math.cos(2*Math.PI* 2*d/size - theta)+1);
				image[y][x] = b;
			}
	}

	private static double square(double x) {
		return x*x;
	}


}

package jp.ac.utokyo.c.graco.isrb.tests;

import jp.ac.utokyo.c.graco.isrb.ImagePanel;

public class IllegalDataTest {

	/**
	 * @param args
	 * @throws InterruptedException 
	 */
	public static void main(String[] args) throws InterruptedException {
		ImagePanel f = ImagePanel.createFrame();
		double[][] a = new double[][]{{0,}, {1,0}, };
		f.showGray(a);
	}

}

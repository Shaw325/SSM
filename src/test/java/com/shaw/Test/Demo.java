package com.shaw.Test;

import java.util.Random;

public class Demo {
	public static void main(String[] args) {
		Random random = new Random();

		for (int i = 0; i < 10; i++) {
			int nextInt = random.nextInt(2);
			int nextInt2 = random.nextInt(2);
			System.out.println("0:" + nextInt);
			System.out.println("1:" + nextInt2);
		}
	}
}

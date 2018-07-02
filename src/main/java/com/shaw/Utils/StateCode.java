package com.shaw.Utils;

public enum StateCode {
	SUCCESS("成功", 100), FAILURE("失败", 200);
	private String state;
	private int code;

	private StateCode(String state, int code) {
		this.state = state;
		this.code = code;
	}

	public String getState() {
		return state;
	}

	public void setState(String state) {
		this.state = state;
	}

	public int getCode() {
		return code;
	}

	public void setCode(int code) {
		this.code = code;
	}

	private StateCode() {
	}

}

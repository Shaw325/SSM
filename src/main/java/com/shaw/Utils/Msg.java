package com.shaw.Utils;

import java.util.HashMap;
import java.util.Map;

public class Msg {
	private StateCode stateCode;
	private Map<String, Object> mp = new HashMap<String, Object>();

	public static Msg Success() {
		Msg msg = new Msg();
		msg.stateCode = StateCode.SUCCESS;
		return msg;
	}

	public static Msg Failure() {
		Msg msg = new Msg();
		msg.stateCode = StateCode.FAILURE;
		return msg;
	}

	public Msg add(String key, Object value) {
		this.getMp().put(key, value);
		return this;
	}

	public StateCode getStateCode() {
		return stateCode;
	}

	public void setStateCode(StateCode stateCode) {
		this.stateCode = stateCode;
	}

	public Map<String, Object> getMp() {
		return mp;
	}

	public void setMp(Map<String, Object> mp) {
		this.mp = mp;
	}

}

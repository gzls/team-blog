package com.cmwebgame.team.common;

import com.cmwebgame.team.demo.tx.TxInterceptor;
import com.cmwebgame.team.demo.UserController;

import com.google.inject.Binder;
import com.google.inject.Module;

public class CommonModule implements Module {

	@Override
	public void configure(Binder binder) {
		binder.bind(UserController.class).asEagerSingleton();
		binder.bind(TxInterceptor.class).asEagerSingleton();
	}

}

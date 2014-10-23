package com.cmwebgame.team.common;

import com.cmwebgame.team.blog.controller.BlogController;
import com.cmwebgame.team.blog.controller.GroupController;
import com.cmwebgame.team.blog.controller.UserController;
import com.google.inject.Binder;
import com.google.inject.Module;

/**
 * 配置POJO
 * @author YouAndMe
 *
 */
public class CommonModule implements Module {

	@Override
	public void configure(Binder binder) {
		binder.bind(BlogController.class).asEagerSingleton();
		binder.bind(UserController.class).asEagerSingleton();
		binder.bind(GroupController.class).asEagerSingleton();
	}

}

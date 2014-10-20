##drop database if exists teamblog;
##create  database teamblog;
##use teamblog;

##用戶信息表

create  table  blog_users  (
   `id` int(11) NOT NULL AUTO_INCREMENT,
   username  varchar(20)  NOT NULL,
   `password`  varchar(20)  NOT NULL,
   email   varchar(40)  NOT NULL,
   realname  char(20)   DEFAULT NULL,
   group_id  int(11)   DEFAULT NULL,
   avatar  varchar(100) DEFAULT NULL,
   `status`  int(11)  DEFAULT 0,
   create_date timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
   PRIMARY KEY (`id`),
   UNIQUE KEY `username` (`username`)
)  ENGINE=InnoDB  DEFAULT CHARSET=utf8;


##日誌表

create table blog_blogs (
   `id` int(11) NOT NULL AUTO_INCREMENT,
   title  varchar(20)  NOT NULL,
   content  varchar(5000)  NOT NULL,
   contentHtml  varchar(5000)  NOT NULL,
   create_date timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
   user_id  int(11),
   PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8;


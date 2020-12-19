CREATE TABLE `users` (
  `id` int PRIMARY KEY AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `user_uuid` varchar(255) NOT NULL,
  `matcher_uuid` varchar(255) NOT NULL COMMENT 'uuid used to match with others',
  `device_id` varchar(255) NOT NULL,
  `mood` int DEFAULT 0,
  `adddate` datetime,
  `moddate` datetime DEFAULT (now())
);

CREATE TABLE `matches` (
  `id` int PRIMARY KEY AUTO_INCREMENT,
  `partner_1` varchar(255) NOT NULL,
  `partner_2` varchar(255) NOT NULL,
  `adddate` datetime
);

CREATE TABLE `notifications` (
  `id` int PRIMARY KEY AUTO_INCREMENT,
  `matcher_uuid` varchar(255),
  `match_id` int,
  `mood` int
);

ALTER TABLE `matches` ADD FOREIGN KEY (`partner_1`) REFERENCES `users` (`matcher_uuid`);

ALTER TABLE `matches` ADD FOREIGN KEY (`partner_2`) REFERENCES `users` (`matcher_uuid`);

ALTER TABLE `matches` ADD FOREIGN KEY (`id`) REFERENCES `notifications` (`match_id`);

ALTER TABLE `users` ADD FOREIGN KEY (`matcher_uuid`) REFERENCES `notifications` (`matcher_uuid`);

CREATE UNIQUE INDEX `unique match` ON `matches` (`partner_1`, `partner_2`);

CREATE UNIQUE INDEX `matches_index_1` ON `matches` (`id`);

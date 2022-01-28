-- a_pinyin-2.sql  a_pinyin/db/  a_pinyin 2.0
-- A拼音 内置数据库 a_pinyin-2.db (由 a_pinyin-2.zip 导入安装)
--
-- > sqlite3 --version
-- 3.37.2 2022-01-06 13:25:41 872ba256cbf61d9290b571c0e6d82a20c224ca3ad82971edc46b29818d5dalt1
--
-- 使用此命令创建内置数据库:
-- > cat a_pinyin-2.sql | sqlite3 a_pinyin-2.db

BEGIN TRANSACTION;


CREATE TABLE a_pinyin (  -- A拼音元数据, 与 1.x 版本兼容
  name TEXT PRIMARY KEY UNIQUE NOT NULL,
  value TEXT,
  `desc` TEXT  -- 描述
);

INSERT INTO a_pinyin(name, value, `desc`) VALUES
  ("a_pinyin version", "2.0.0-a1", "a_pinyin.apk 的版本"),
  ("db_version", "2.0.0-a1", "数据库格式版本"),
  ("db_type", "2", "本数据库的类型: A拼音 2.0 内置数据库"),
  ("lang", "zh_CN", "语言: 简体中文  Language: Chinese"),
  ("url", "https://github.com/fm-elpac/a_pinyin", "本项目源代码地址"),
  ("url2", "TODO", "本项目源代码地址 (镜像)"),
  ("data_version", "0.1.0", "本数据库中数据的版本"),
  ("last_update", strftime("%Y-%m-%dT%H:%M:%fZ", "now"), "最后更新时间");


CREATE TABLE a_pinyin_元数据 (  -- A拼音 2.0 数据库元数据
  类型 TEXT NOT NULL,
  名称 TEXT NOT NULL,
  值 TEXT,
  描述 TEXT,
  备注 TEXT,
  时间 REAL NOT NULL DEFAULT 0,  -- [可选] 创建时间或更新时间  Julian (date) time

  PRIMARY KEY (类型, 名称, 值)
);

-- TODO 当前时间
INSERT INTO a_pinyin_元数据(类型, 名称, 值, 描述, 备注) VALUES
  ("表", "a_pinyin", NULL, "A拼音 元数据, 与 1.x 本版兼容", NULL),
  ("表", "a_pinyin_元数据", NULL, "A拼音 2.0 数据库元数据", NULL),
  -- TODO
  ("枚举", "a_pinyin_元数据.类型", "表", "对数据库中每张表的描述", NULL),
  ("枚举", "a_pinyin_元数据.类型", "枚举", "对某表某列枚举值的描述", NULL);
-- TODO


-- TODO

COMMIT;

-- ANALYZE;
-- .selftest --init
-- VACUUM;

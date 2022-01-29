-- a_pinyin-2u.sql  a_pinyin/db/  a_pinyin 2.0
-- A拼音 用户数据库 a_pinyin-2u.db
--
-- > sqlite3 --version
-- 3.37.2 2022-01-06 13:25:41 872ba256cbf61d9290b571c0e6d82a20c224ca3ad82971edc46b29818d5dalt1
--
-- 使用此命令创建内置数据库:
-- > cat a_pinyin-2u.sql | sqlite3 a_pinyin-2u.db

BEGIN TRANSACTION;

-- ####
CREATE TABLE a_pinyin (  -- A拼音元数据, 与 1.x 版本兼容
  name TEXT PRIMARY KEY UNIQUE NOT NULL,
  value TEXT,
  `desc` TEXT  -- 描述
);

INSERT INTO a_pinyin(name, value, `desc`) VALUES
  ("a_pinyin version", "2.0.0-a1", "a_pinyin.apk 的版本"),
  ("db_version", "2.0.0-a1", "数据库格式版本"),
  ("db_type", "2u", "本数据库的类型: A拼音 2.0 用户数据库"),
  ("lang", "zh_CN", "语言: 简体中文  Language: Chinese"),
  ("url", "https://github.com/fm-elpac/a_pinyin", "本项目源代码地址"),
  ("url2", "TODO", "本项目源代码地址 (镜像)"),
  ("data_version", "0.1.0", "本数据库中数据的版本"),
  ("last_update", strftime("%Y-%m-%dT%H:%M:%fZ", "now"), "最后更新时间");

-- ####
CREATE TABLE a_pinyin_元数据 (  -- A拼音 2.0 数据库元数据
  类型 TEXT NOT NULL,
  名称 TEXT NOT NULL,
  值 TEXT,
  描述 TEXT,
  备注 TEXT,
  时间 REAL NOT NULL DEFAULT 0,  -- [可选] 创建时间或更新时间  Julian (date) time

  PRIMARY KEY (类型, 名称, 值)
);

INSERT INTO a_pinyin_元数据(类型, 名称, 值, 描述, 备注) VALUES
  ("表", "a_pinyin", NULL, "A拼音 元数据, 与 1.x 本版兼容", NULL),
  ("表", "a_pinyin_元数据", NULL, "A拼音 2.0 数据库元数据", NULL),
  ("表", "用户_配置", NULL, "保存设置表", NULL),
  ("表", "用户_字符", NULL, "对应 固定_字符", NULL),
  ("表", "用户_拼音", NULL, "对应 基础_拼音", NULL),
  ("表", "用户_汉字", NULL, "对应 基础_汉字", NULL),
  ("表", "用户_c1_双拼", NULL, "对应 c1_双拼", NULL),
  ("表", "用户_c1_拼音切分", NULL, "记录拼音切分选择结果", NULL),
  ("表", "用户_c1_词典", NULL, "用户输入 1 元词典", NULL),
  ("表", "用户_c1_词典2", NULL, "用户输入 2 元词典", NULL),

  ("枚举", "a_pinyin_元数据.类型", "表", "对数据库中每张表的描述", NULL),
  ("枚举", "a_pinyin_元数据.类型", "枚举", "对某表某列枚举值的描述", NULL);

-- ####
CREATE TABLE 用户_配置 (
  键 TEXT NOT NULL,
  值 TEXT,
  说明 TEXT,
  备注 TEXT,
  时间 REAL NOT NULL DEFAULT 0,

  PRIMARY KEY (键)
);

-- ####
CREATE TABLE 用户_字符 (
  类型 TEXT NOT NULL,
  文本 TEXT NOT NULL,
  次数 INT NOT NULL DEFAULT 0,
  时间 REAL NOT NULL DEFAULT 0,

  PRIMARY KEY (类型, 文本)
) WITHOUT ROWID;

CREATE INDEX i_用户_字符_次数
ON 用户_字符(次数);

CREATE INDEX i_用户_字符_时间
ON 用户_字符(时间);

-- ####
CREATE TABLE 用户_拼音 (
  类型 TEXT NOT NULL,
  文本 TEXT NOT NULL,
  次数 INT NOT NULL DEFAULT 0,
  时间 REAL NOT NULL DEFAULT 0,

  PRIMARY KEY (文本)
) WITHOUT ROWID;

CREATE INDEX i_用户_拼音_次数
ON 用户_拼音(次数);

CREATE INDEX i_用户_拼音_时间
ON 用户_拼音(时间);

-- ####
CREATE TABLE 用户_c1_双拼 (
  名称 TEXT NOT NULL,
  双拼 TEXT NOT NULL,
  pin_yin TEXT NOT NULL,
  次数 INT NOT NULL DEFAULT 0,
  时间 REAL NOT NULL DEFAULT 0,

  PRIMARY KEY (名称, 双拼, pin_yin)
) WITHOUT ROWID;

CREATE INDEX i_用户_c1_双拼_次数
ON 用户_c1_双拼(次数);

CREATE INDEX i_用户_c1_双拼_时间
ON 用户_c1_双拼(时间);

-- ####
CREATE TABLE 用户_汉字 (
  全拼 TEXT NOT NULL,
  声母 TEXT NOT NULL,
  汉字 TEXT NOT NULL,
  声调 INT NOT NULL DEFAULT 0,
  次数 INT NOT NULL DEFAULT 0,
  时间 REAL NOT NULL DEFAULT 0,

  PRIMARY KEY (全拼, 汉字, 声调)
) WITHOUT ROWID;

CREATE INDEX i_用户_汉字_声母
ON 用户_汉字(声母);

CREATE INDEX i_用户_汉字_次数
ON 用户_汉字(次数);

CREATE INDEX i_用户_汉字_时间
ON 用户_汉字(时间);

-- ####
CREATE TABLE 用户_c1_拼音切分 (
  模式 TEXT NOT NULL,
  原始 TEXT NOT NULL,
  pin_yin TEXT NOT NULL,
  次数 INT NOT NULL DEFAULT 0,
  时间 REAL NOT NULL DEFAULT 0,

  PRIMARY KEY (模式, 原始, pin_yin)
) WITHOUT ROWID;

CREATE INDEX i_用户_c1_拼音切分_次数
ON 用户_c1_拼音切分(次数);

CREATE INDEX i_用户_c1_拼音切分_时间
ON 用户_c1_拼音切分(时间);

-- ####
CREATE TABLE 用户_c1_词典 (
  pin_yin TEXT NOT NULL,
  声调 TEXT,
  文本 TEXT NOT NULL,
  次数 INT NOT NULL DEFAULT 0,
  时间 REAL NOT NULL DEFAULT 0,

  PRIMARY KEY (pin_yin, 声调, 文本)
) WITHOUT ROWID;

CREATE INDEX i_用户_c1_词典_次数
ON 用户_c1_词典(次数);

CREATE INDEX i_用户_c1_词典_时间
ON 用户_c1_词典(时间);

-- ####
CREATE TABLE 用户_c1_词典2 (
  pin_yin TEXT NOT NULL,
  文本 TEXT NOT NULL,
  之前 TEXT NOT NULL,
  次数 INT NOT NULL DEFAULT 0,
  时间 REAL NOT NULL DEFAULT 0,

  PRIMARY KEY (pin_yin, 文本, 之前)
) WITHOUT ROWID;

CREATE INDEX i_用户_c1_词典2_次数
ON 用户_c1_词典2(次数);

CREATE INDEX i_用户_c1_词典2_时间
ON 用户_c1_词典2(时间);

-- ####
COMMIT;

-- 清理
ANALYZE;
VACUUM;

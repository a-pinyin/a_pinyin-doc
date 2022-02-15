-- a_pinyin-2.sql  a_pinyin/db/  a_pinyin 2.0
-- A拼音 内置数据库 a_pinyin-2.db (由 a_pinyin-2.zip 导入安装)
--
-- > sqlite3 --version
-- 3.37.2 2022-01-06 13:25:41 872ba256cbf61d9290b571c0e6d82a20c224ca3ad82971edc46b29818d5dalt1
--
-- 使用此命令创建内置数据库:
-- > cat a_pinyin-2.sql | sqlite3 a_pinyin-2.db

BEGIN TRANSACTION;

-- ####
CREATE TABLE a_pinyin (  -- A拼音元数据, 与 1.x 版本兼容
  name TEXT PRIMARY KEY UNIQUE NOT NULL,
  value TEXT,
  `desc` TEXT  -- 描述
);

INSERT INTO a_pinyin(name, value, `desc`) VALUES
  ("a_pinyin version", "2.0.0-a2", "a_pinyin.apk 的版本"),
  ("db_version", "2.0.0-a2", "数据库格式版本"),
  ("db_type", "2", "本数据库的类型: A拼音 2.0 内置数据库"),
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
  ("表", "固定_字符", NULL, "内置固定输入字符表", NULL),
  ("表", "基础_拼音", NULL, "全拼拼音基础数据", NULL),
  ("表", "基础_汉字", NULL, "基础汉字数据", NULL),
  ("表", "c1_双拼", NULL, "内置双拼方案", NULL),
  ("表", "c1_词典", NULL, "内置 1 元词典", NULL),
  ("表", "c1_词典拼音", NULL, "用于 前缀2 查找", NULL),
  ("表", "默认配置", NULL, "核心模块等配置参数的默认值", NULL),

  ("枚举", "a_pinyin_元数据.类型", "表", "对数据库中每张表的描述", NULL),
  ("枚举", "a_pinyin_元数据.类型", "枚举", "对某表某列枚举值的描述", NULL),
  ("枚举", "固定_字符.类型", "ASCII", "所有 ASCII 可输入字符, 控制字符除外", NULL),
  ("枚举", "固定_字符.类型", "数字", "0-9", NULL),
  ("枚举", "固定_字符.类型", "英文字母大写", "A-Z", NULL),
  ("枚举", "固定_字符.类型", "英文字母小写", "a-z", NULL),
  ("枚举", "固定_字符.类型", "A", "ASCII 中的符号", NULL),
  ("枚举", "固定_字符.类型", "中文标点", "高频常用中文标点", NULL),
  ("枚举", "固定_字符.类型", "自定义1", "内置自定义输入", NULL),
  ("枚举", "基础_拼音.类型", "全拼", "单个拼音不带声调", NULL),
  ("枚举", "基础_拼音.类型", "声母", "", NULL),
  ("枚举", "基础_拼音.类型", "韵母", "", NULL);

-- ####
CREATE TABLE 固定_字符 (
  类型 TEXT NOT NULL,
  文本 TEXT NOT NULL,
  次数 INT NOT NULL DEFAULT 0,

  PRIMARY KEY (类型, 文本)
) WITHOUT ROWID;

CREATE INDEX i_固定_字符_次数
ON 固定_字符(次数);

-- ####
CREATE TABLE 基础_拼音 (
  类型 TEXT NOT NULL,
  文本 TEXT NOT NULL,
  次数 INT NOT NULL DEFAULT 0,

  PRIMARY KEY (文本)
) WITHOUT ROWID;

-- ####
CREATE TABLE c1_双拼 (
  名称 TEXT NOT NULL,
  双拼 TEXT NOT NULL,
  pin_yin TEXT NOT NULL,

  PRIMARY KEY (名称, 双拼, pin_yin)
) WITHOUT ROWID;

-- ####
CREATE TABLE 基础_汉字 (
  全拼 TEXT NOT NULL,
  声母 TEXT NOT NULL,
  汉字 TEXT NOT NULL,
  分级 INT NOT NULL,
  声调 INT NOT NULL DEFAULT 0,
  次数 INT NOT NULL DEFAULT 0,

  PRIMARY KEY (全拼, 汉字, 声调)
) WITHOUT ROWID;

CREATE INDEX i_基础_汉字_分级
ON 基础_汉字(分级);

CREATE INDEX i_基础_汉字_声母
ON 基础_汉字(声母);

CREATE INDEX i_基础_汉字_次数
ON 基础_汉字(次数);

-- ####
CREATE TABLE c1_词典 (
  文本 TEXT NOT NULL,
  次数 INT NOT NULL DEFAULT 0,
  前缀2 TEXT NOT NULL,

  PRIMARY KEY (文本)
) WITHOUT ROWID;

CREATE INDEX i_c1_词典_次数
ON c1_词典(次数);

CREATE INDEX i_c1_词典_前缀2
ON c1_词典(前缀2);

-- ####
CREATE TABLE c1_词典拼音 (
  pin_yin TEXT NOT NULL,
  p_y TEXT NOT NULL,
  前缀2 TEXT NOT NULL,

  PRIMARY KEY (pin_yin, 前缀2)
) WITHOUT ROWID;

CREATE INDEX i_c1_词典拼音_py
ON c1_词典拼音(p_y);

-- ####
CREATE TABLE 默认配置 (
  键 TEXT NOT NULL,
  值 TEXT,
  说明 TEXT,
  备注 TEXT,

  PRIMARY KEY (键)
);

-- ####
COMMIT;

-- 清理
ANALYZE;
.selftest --init
VACUUM;

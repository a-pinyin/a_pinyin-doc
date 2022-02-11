# sqlite 抽象层

用于简化数据库层的实现, 可以一套数据库层 (rust/WASM),
兼容多个平台的具体的 sqlite 封装库, 比如:

- rusqlite (rust)

- sqflite (flutter/dart)

- sql.js (web)

具体协议为 `JSON-RPC`.

TODO

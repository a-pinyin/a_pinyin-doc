#!/bin/bash
rm -f a_pinyin-2.db; cat a_pinyin-2.sql | sqlite3 a_pinyin-2.db
rm -f a_pinyin-2u.db; cat a_pinyin-2u.sql | sqlite3 a_pinyin-2u.db

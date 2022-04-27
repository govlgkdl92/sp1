package org.zerock.sp1.mapper;

import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Select;

public interface TimeMapper {

    //@Select("select now()")
    String getTime();
    String getDate();

    @Insert("insert into tbl_a (text) values (#{text})")
    void insertA(String text);

    @Insert("insert into tbl_b (text) values (#{text})")
    void insertB(String text);
}

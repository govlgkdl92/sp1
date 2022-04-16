package org.zerock.sp1.mapper;

import org.apache.ibatis.annotations.Select;

public interface TimeMapper {

    //@Select("select now()")
    String getTime();

    String getDate();
}

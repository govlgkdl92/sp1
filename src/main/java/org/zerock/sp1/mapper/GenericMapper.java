package org.zerock.sp1.mapper;

import org.apache.ibatis.annotations.Param;
import org.zerock.sp1.domain.Board;
import org.zerock.sp1.dto.ListDTO;

import java.util.List;

public interface GenericMapper <E, K>{

    void insert(E board);
    List<Board> selectList(ListDTO listDTO);
                        //(@Param("skip") int skip, @Param("size")int size);
    int getTotal(ListDTO listDTO);
    void delete(K bno);
    Board selectOne(K bno);
    void update(E board);
}
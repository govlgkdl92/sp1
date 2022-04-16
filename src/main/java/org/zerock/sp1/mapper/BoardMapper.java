package org.zerock.sp1.mapper;

import org.apache.ibatis.annotations.Param;
import org.zerock.sp1.domain.Board;
import org.zerock.sp1.dto.ListDTO;

import java.util.List;

public interface BoardMapper {

    void insert(Board board); //보드 인서트
    void delete(Integer bno); //보드 삭제
    Board selectOne(Integer bno); //하나의 게시물
    void update(Board board); //보드 하나의 게시물 수정
    List<Board> selectList(ListDTO listDTO);

    int getTotal(ListDTO listDTO);

    //@Param(("skip")) int skip, @Param("size")int size); //보드 리스트


}

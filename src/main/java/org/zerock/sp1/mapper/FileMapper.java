package org.zerock.sp1.mapper;

import org.zerock.sp1.domain.AttachFile;

public interface FileMapper{

    void insert(AttachFile attachFile); //mapping 테이블에 이미지 등록

    void insertBoard(AttachFile attachFile);

    void delete(Integer bno);; //이미지 삭제
}

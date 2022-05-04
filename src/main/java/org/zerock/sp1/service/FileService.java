package org.zerock.sp1.service;



//이미지 독립적인 DB 등록 시 사용
//게시판에 종속적인 DB 등록시에는 BoardService 에 넣어야함

import org.zerock.sp1.dto.UploadResultDTO;

public interface FileService {
    void register(UploadResultDTO uploadResultDTO); // 파일 등록
    void remove(String uuid); // 파일 삭제


}

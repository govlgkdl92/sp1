package org.zerock.sp1.service;

import lombok.RequiredArgsConstructor;
import lombok.extern.log4j.Log4j2;
import org.modelmapper.ModelMapper;
import org.springframework.stereotype.Service;
import org.zerock.sp1.domain.AttachFile;
import org.zerock.sp1.dto.UploadResultDTO;
import org.zerock.sp1.mapper.FileMapper;

@Service
@RequiredArgsConstructor
@Log4j2
public class FileServiceImpl implements FileService {

    private final FileMapper fileMapper;
    private final ModelMapper modelMapper;

    //이미지 독립적인 DB 등록 시 사용

    //파일 업로드
    @Override
    public void register(UploadResultDTO uploadResultDTO) {
        //UploadResultDTO => AttachFile 변환 해야돼
        //변수 명이 안맞아! original -> fileName
        //오늘은 그냥 UploadResult 의 변수명 자체를 바꿔줘서 똑같이 만들게!

        AttachFile attachFile = modelMapper.map(uploadResultDTO, AttachFile.class);
        fileMapper.insert(attachFile);
    }

    @Override
    public void remove(String uuid) {
        fileMapper.delete(uuid);
    }
}

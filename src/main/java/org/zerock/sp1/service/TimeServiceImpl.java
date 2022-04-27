package org.zerock.sp1.service;

import lombok.RequiredArgsConstructor;
import lombok.extern.log4j.Log4j2;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.zerock.sp1.mapper.TimeMapper;

@Service
@RequiredArgsConstructor
@Log4j2
public class TimeServiceImpl implements TimeService{

    private final TimeMapper timeMapper;

    @Transactional
    @Override
    public void insertAll(String text){
        timeMapper.insertA(text);
        timeMapper.insertB(text);

    }
}

package org.zerock.sp1.service;

import org.springframework.transaction.annotation.Transactional;

@Transactional
public interface TimeService {
    void insertAll(String text);

}

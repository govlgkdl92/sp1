package org.zerock.sp1.sample;

import lombok.RequiredArgsConstructor;
import lombok.ToString;
import org.springframework.stereotype.Service;

@ToString
@RequiredArgsConstructor
@Service
public class SampleService {

    private final SampleDAO dao;

}

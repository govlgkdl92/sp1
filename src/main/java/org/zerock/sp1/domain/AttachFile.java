package org.zerock.sp1.domain;

import lombok.*;

@Getter
@AllArgsConstructor
@NoArgsConstructor
@Builder
@ToString
public class AttachFile {
    //매퍼에 쓰려고 해당 파일을 만듦!
    private String uuid; //pk
    private Integer bno; //board fk(bno)
    private String fileName;
    private String savePath;
    private boolean img;
}

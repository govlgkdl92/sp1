package org.zerock.sp1.dto;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@Builder
@AllArgsConstructor
@NoArgsConstructor
public class UploadResultDTO {

    private String uuid; //uuid (pk 역할)
    private String fileName; //오리지날 파일의 이름
    private String savePath; //파일경로(날짜만)
    private boolean img; //이미지 존재 여부

    public String getLink(){
        return savePath+"/"+uuid+"_"+fileName;
    }
    public String getThumbnail(){
        return savePath+"/s_"+uuid+"_"+fileName;
    }
}

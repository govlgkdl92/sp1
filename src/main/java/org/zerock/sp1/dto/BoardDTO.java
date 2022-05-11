package org.zerock.sp1.dto;

import com.fasterxml.jackson.annotation.JsonFormat;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class BoardDTO {
    private Integer bno;
    private String title;
    private String content;
    private String writer;
    private Integer replyCount;
    //mainImage 의 섬네일의 링크
    private String mainImage;

    @JsonFormat(pattern="yyyy-MM-dd HH:mm:ss")
    private LocalDateTime regdate;
    @JsonFormat(pattern="yyyy-MM-dd HH:mm:ss")
    private LocalDateTime updatedate;

    private List<UploadResultDTO> uploads = new ArrayList<>();

    public String getMain(){
        if(mainImage == null){
            return null;
        }

        int idx = mainImage.indexOf("s_");
        String first = mainImage.substring(0, mainImage.indexOf("s_")); /* 필요한 S_ 가 처음 나올 수 밖에 없으므로 substring으로 처리 */
        String second = mainImage.substring(idx+2);
        
        //섬네일이 아닌 원본 이미지 출력
        return first+second;
    }
}

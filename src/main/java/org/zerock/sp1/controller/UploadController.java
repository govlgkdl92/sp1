package org.zerock.sp1.controller;

import lombok.RequiredArgsConstructor;
import lombok.extern.log4j.Log4j2;
import net.coobird.thumbnailator.Thumbnails;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import org.zerock.sp1.dto.UploadResultDTO;
import org.zerock.sp1.service.FileService;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.nio.file.Files;
import java.text.SimpleDateFormat;
import java.util.*;

@Controller
@Log4j2
@RequiredArgsConstructor
public class UploadController {

    //독립적인 DB 처리할 때
    //private final FileService fileService;

    //이미지 보이기
    @GetMapping("/view")  //  /{fileName:.+}
    public ResponseEntity<byte[]> viewFile(String fileName){  //@PathVariable("fileName")
        log.info("--------------------: "+fileName);

        File targetFile = new File("D:\\upload\\temp\\"+fileName);

        try {
            String mimeType = Files.probeContentType(targetFile.toPath());

            log.info("========================");
            log.info(mimeType);

            byte[] data = FileCopyUtils.copyToByteArray(targetFile);

            return ResponseEntity.ok().header("Content-Type",mimeType)
                    .body(data);

        } catch (IOException e) {
            e.printStackTrace();
            return ResponseEntity.status(404).build();
        }

    }


    //이미지 업로드
    @ResponseBody //-> 옛날에는 이것을 붙임으로 list를 보내줌. 지금의 RestController 의 역할
    @PostMapping("/upload1")      //여러개의 파일을 받고 싶을 때는 배열로 처리한다.
    public List<UploadResultDTO> upload1(MultipartFile[] files){
        //log.info("----------file---------");
        //log.info(files);
        //log.info("-----------------------");

        List<UploadResultDTO> list = new ArrayList<>();

        //업로드 된 파일이 있다고 가정한다.
        for(MultipartFile file:files){
                       // 업로드 되는 파일 이름
            String originalFileName = file.getOriginalFilename();

            log.info("type: "+file.getContentType());
            //썸네일을 위해 이미지를 걸려야 하는데.. 만약 이미지 타입이라면 썸네일을 만들어야 하니까!
            //이미지 거르기 방법1 mine 타입으로 확인해볼 수 있는 방법
            boolean img = file.getContentType().startsWith("image"); //이미지 여부
            String uuid = UUID.randomUUID().toString();
            String saveName = uuid+"_"+originalFileName;
                             //최종적으로 저장되는 파일 이름, 중복을 방지하기 위해서 사용된다.

            //log.info("---------upload file---------: "+file.getResource());

            String saveFolder = makeFolders();
            //날짜별로 첨부파일 정리하기

            File saveFile = new File("D:\\upload\\temp\\"+saveFolder+"\\"+saveName);

            // 서버까지 파일 업로드가 된 상태... 이제 저장을 해야하는데!
            try (InputStream in = file.getInputStream();
                 FileOutputStream fos =
                         new FileOutputStream(saveFile);
            ) {
                FileCopyUtils.copy(in, fos);

                //이미지 거르기 방법2
                //Files.probeContentType();
            } catch (IOException e) {
                e.printStackTrace();
            }

            if(img){
                //saveName == UUID + "_" + fileName
                String thumbFileName = saveFolder+"\\s_"+saveName;
                File thumbFile = new File("D:\\upload\\temp\\"+thumbFileName);

                try {
                    Thumbnails.of(saveFile)
                            .size(200, 200)
                            .toFile(thumbFile);
                } catch (IOException e) {
                    e.printStackTrace();
                }
            }//end if(boolean img)

            UploadResultDTO uploadResultDTO = UploadResultDTO.builder()
                    .fileName(originalFileName)
                    .uuid(uuid)
                    .savePath(saveFolder)
                    .img(img)
                    .build();

            list.add(uploadResultDTO);
            
            //독립적인 DB 등록시
            //fileService.register(uploadResultDTO); //파일매퍼 테이블에 upload 파일 정보 보내기


            //nginx 에 경로를 잡아주면 이미지를 볼 수는 있지만 권한이 없는 사용자도 모든 파일을 볼 수 있다..
            //때문에...
            //원칙적으로는 spring 에서 볼 수 있도록 처리하면
            //security 로 제한을 걸어서 권한이 없는 사람들은 이미지를 못보게 막을 수 있다.

            //resources 안에 이미지를 넣는 거는 어때?? - > 안돼요...
            //우리의 폴더에는 쌓이겠지만 실제 돌아가는 톰캣에는 쌓이지 않는다.
            //실제 돌아가는 톰캣 경로에 업로드를 하면 프로젝트가 deploy 되면 전부 삭제 되버리낟.

            
            //해야 할 일
            //첨부파일을 보거나 다운로드를 받을 때 권한이 있는 사용자들만 접근 하겠금 막아주기 위해 spring 에서 처리해야 한다.
            //파일을 삭제하거나 수정할 때, 썸네일도 같이 삭제하거나 수정해야 한다.
            
        }//end for

        return list;
    }//end upload1


    //폴더의 경로 만들어주기 // 폴더가 있었으면 안만들어진다 기본에 있던 폴더로 들어감
    private String makeFolders(){
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy/MM/dd");
        String str = sdf.format(new Date()); //new Date 나는 java.util 에 있는 것으로 사용한다.

        File folderPath = new File("D:\\upload\\temp\\"+str);

        if(!folderPath.exists()){ //이 경로가 존재하지 않는다면?
            folderPath.mkdirs();
        }

        return str;
    }//end makeFolders



    //파일 삭제하기
    @PostMapping("/delete")
    @ResponseBody //이거 안주면 응답이 안나간다.
    public Map<String, String> deleteFile(String fileName){
        int idx = fileName.lastIndexOf("/");
        String path = fileName.substring(0, idx); //경로
        String name = fileName.substring(idx+1); //삭제할 파일 이름

        log.info("path: "+path);
        log.info("name: "+name);

        File targetFile = new File("D:\\upload\\temp\\"+fileName);
        boolean result = targetFile.delete();
        //원본 파일 삭제 후 삭제 성공하면 섬네일 삭제하기
        if(result){
            File thumbFile = new File("D:\\upload\\temp\\"+path+"\\s_"+name);
            thumbFile.delete();
        }

        //name -> uuid_fileName 상태 _ 앞에 uuid만 가져오기
        String uuid = name.substring(0,name.indexOf("_"));
        
        //독립적인 DB등록 방법
        //fileService.remove(uuid);

        return Map.of("result", "success");
    }


    // 화면을 아예 나갔을 경우 DB 안에 이미지 처리 에 대한 이슈가 생긴다.
    // window 닫기 창을 눌렀을 때 경고창을 띄우고, DB 값을 삭제할 수 있도록 한다.
    // 하지만 컴퓨터가 강제로 꺼졌을 경우의 문제는 해결 할 수 없는 문제가 생긴다.

    // 대표 이미지 선택 -> 파일 수정, 삭제 시 board 안에 들어가는 대표 이미지 속성에 문제가 생긴다.
    // 체크 박스를 이용해서 사용자가 대표 이미지 선택할 수 있도록 하자.
    

}

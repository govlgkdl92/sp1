package org.zerock.sp1.store;


import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.context.annotation.Primary;
import org.springframework.stereotype.Component;
import org.springframework.stereotype.Repository;

//@Primary
@Qualifier("KoreanChef")
@Repository//annotation
public class KoreanChef implements Chef{

    @Override
    public String cook() {
        return "한우육회덮밥";
    }

    @Override
    public String cooker() {
        return "백종원";
    }
}


/*



*/

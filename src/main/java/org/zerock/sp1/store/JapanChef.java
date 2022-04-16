package org.zerock.sp1.store;

import jdk.jfr.Percentage;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.context.annotation.Primary;
import org.springframework.stereotype.Component;
import org.springframework.stereotype.Repository;

//@Primary
@Qualifier("JapanChef")
@Repository
public class JapanChef implements Chef {

    @Override
    public String cook() {
        return "돈부리";
    }

    @Override
    public String cooker() {
        return "마쵸";
    }
}

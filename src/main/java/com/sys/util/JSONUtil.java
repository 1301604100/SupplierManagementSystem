package com.sys.util;

import java.util.List;

public class JSONUtil {

    public String ToJson(String list, int count){
        String json = null;
        String json_1 = "{\"code\":0,\"msg\":\"\",\"count\":";
        String json_2 = ",\"data\":";
        json = json_1 + count + json_2 + list + "}";
        return json;
    }
}



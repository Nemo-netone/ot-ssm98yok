package com.controller;

import java.util.HashMap;
import java.util.Map;

import com.annotation.IgnoreAuth;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
public class HealthController {

    @RequestMapping("/health")
    @IgnoreAuth
    public Map<String, Object> health() {
        Map<String, Object> result = new HashMap<String, Object>();
        result.put("ok", true);
        result.put("service", "ot-ssm98yok-api");
        return result;
    }
}

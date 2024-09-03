package com.example.WebsiteCounter;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import jakarta.servlet.http.HttpSession;

@Controller
public class CounterController {

    @GetMapping("/")
    public String countVisits(HttpSession session, Model model) {
        Integer visitCount = (Integer) session.getAttribute("visitCount");

        if (visitCount == null) {
            visitCount = 0;
        }

        visitCount++;
        session.setAttribute("visitCount", visitCount);
        model.addAttribute("visitCount", visitCount);

        return "index";
    }
}
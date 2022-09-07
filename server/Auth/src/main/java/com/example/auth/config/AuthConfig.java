package com.example.auth.config;

import com.example.auth.models.AuthUser;
import com.example.auth.repository.AuthRepository;
import org.springframework.boot.CommandLineRunner;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

import java.util.List;

@Configuration
public class AuthConfig {
    @Bean
    CommandLineRunner commandLineRunner(AuthRepository repository)
    {
        return args ->
        {
            AuthUser danzel = new AuthUser(
                    "Danzel",
                    "Sally",
                    "ddd@kmail.com",
                    "+1 777 345 5678");
            AuthUser jared = new AuthUser(
                    "Jared",
                    "Danne",
                    "kkkfk@llll",
                    "+34 890 899 8989");
            AuthUser fred = new AuthUser(
                    "Fred",
                    "Aemy",
                    "ririhg@lrjjfr",
                    "");
            AuthUser joui = new AuthUser(
                    "Joui",
                    "Tribbiany",
                    "fjjdhdh@lfkjf",
                    "+7 788 882 3132");


            repository.saveAll(
                    List.of(danzel, jared, fred, joui)
            );
        };
    }
}

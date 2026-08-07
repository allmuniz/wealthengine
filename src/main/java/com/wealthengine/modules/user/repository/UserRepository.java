package com.wealthengine.modules.user.repository;

import com.wealthengine.modules.user.entity.UserEntity;
import org.springframework.data.jpa.repository.JpaRepository;

public interface UserRepository extends JpaRepository<UserEntity, Long> {
}

package dev.mvc.member;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository("dev.mvc.member.MemberDAO")
public class MemberDAO implements MemberDAOInter {
  @Autowired
  private SqlSessionTemplate mybatis;

  public MemberDAO() {
    System.out.println("--> MemberDAO created.");
  }

  @Override
  public int checkId(String id) {
    return mybatis.selectOne("member.checkId", id);
  }

  @Override
  public int create(MemberVO vo) {
    return mybatis.insert("member.create", vo);
  }

  @Override
  public List<MemberVO> list() {
    return mybatis.selectList("member.list");
  }

  @Override
  public MemberVO read(int mno) {
    return mybatis.selectOne("member.read", mno);
  }

  @Override
  public int update(MemberVO memberVO) {
    return mybatis.update("member.update", memberVO);
  }

  @Override
  public int passwdCheck(Map map) {
    return mybatis.selectOne("member.passwdCheck", map);
  }

  @Override
  public int update_passwd(Map map) {
    return mybatis.update("member.update_passwd", map);
  }

  @Override
  public int delete(int mno) {
    return mybatis.delete("member.delete", mno);
  }

  @Override
  public int login(MemberVO memberVO) {
    return mybatis.selectOne("member.login", memberVO);
  }

  @Override
  public MemberVO sessionid(String id) {
    return mybatis.selectOne("member.sessionid",id);
  }
  
}





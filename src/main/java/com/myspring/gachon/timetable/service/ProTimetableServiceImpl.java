package com.myspring.gachon.timetable.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.myspring.gachon.member.myinfo.vo.MyInfoVO;
import com.myspring.gachon.timetable.dao.ProTimetableDao;
import com.myspring.gachon.timetable.vo.ProTimetableVo;

@Service
public class ProTimetableServiceImpl implements ProTimetableService {

	@Autowired
	private ProTimetableDao ProTimetableDao;

	@Override
	public List<ProTimetableVo> selectProTimetableinfo(ProTimetableVo vo) {
		return ProTimetableDao.selectProTimetableinfo(vo);
	}

}




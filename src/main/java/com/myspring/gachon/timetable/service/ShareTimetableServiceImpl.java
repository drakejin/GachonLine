package com.myspring.gachon.timetable.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.myspring.gachon.timetable.dao.ShareTimetableDao;
import com.myspring.gachon.timetable.vo.ShareTimetableVo;
import com.myspring.gachon.timetable.vo.ShowTimetableVo;

@Service
public class ShareTimetableServiceImpl implements ShareTimetableService {
	@Autowired
	ShareTimetableDao shareTimetableDaoImpl;

	@Override
	public List<ShareTimetableVo> selectMyfnd(int memberId) {
		return shareTimetableDaoImpl.selectMyfnd(memberId);	
	}
	
	@Override
	public List<ShareTimetableVo> selectFndInfo(int memberId) {
		return shareTimetableDaoImpl.selectFndInfo(memberId);
	}
	
	
}

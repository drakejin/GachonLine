package com.myspring.gachon.timetable.service;

import java.util.List;

import com.myspring.gachon.timetable.vo.ProTimetableVo;
import com.myspring.gachon.timetable.vo.ShowTimetableVo;

public interface ProTimetableService {

	List<ProTimetableVo> selectProTimetableinfo(ProTimetableVo vo);
}

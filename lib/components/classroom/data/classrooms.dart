import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ClassRooms {
  String subject;
  String batch;
  String branch;
  String section;
  String createdBy;

  ClassRooms(
      {this.subject,
      this.batch,
      this.branch,
      this.section,
      this.createdBy});
}

List classRoomDesingList = [
  {
    "bannerImg": AssetImage("assets/banner1.jpg"),
     "clrs": [255, 233, 116, 57]
  },
  {
       "bannerImg": AssetImage("assets/banner2.jpg"),
       "clrs": [255, 101, 237, 153]
  },
  {
    "bannerImg": AssetImage("assets/banner3.jpg"),
    "clrs": [255, 111, 27, 198],
  },
  {
  "bannerImg": AssetImage("assets/banner4.jpg"),
  "clrs": [255, 0, 0, 0],
  },
  {
  "bannerImg": AssetImage("assets/banner5.jpg"),
  "clrs": [255, 102, 153, 204],
  },
  {
  "bannerImg": AssetImage("assets/banner6.jpg"),
  "clrs": [255, 111, 27, 198],
  },
  {
  "bannerImg": AssetImage("assets/banner7.jpg"),
  "clrs": [255, 95, 139, 233],
  },
  {
    "bannerImg": AssetImage("assets/banner8.jpg"),
    "clrs": [255, 95, 139, 233],
  },
  {
  "bannerImg": AssetImage("assets/banner9.jpg"),
  "clrs": [255, 101, 237, 153],
  },
  {
  "bannerImg": AssetImage("assets/banner11.jpg"),
  "clrs": [255, 95, 139, 233],
  },
  {
  "bannerImg": AssetImage("assets/banner10.jpg"),
  "clrs": [255, 102, 153, 204],
  },
  {
  "bannerImg": AssetImage("assets/banner12.jpg"),
  "clrs": [255, 102, 153, 204],
  }

  ];
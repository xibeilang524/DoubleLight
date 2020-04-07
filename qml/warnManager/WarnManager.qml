import QtQuick.Controls 2.5
import QtQuick 2.0
import WarnModel 1.0
import "../playbackVideo"
import "../dialog"
Rectangle {
    id: root
    property int checkedHeaderLeftMargin: 20
    property int warnTimeHeaderLeftMargin: 44
    property int warnTempHeaderLeftMargin: 304
    property int warnImgHeaderLeftMargin: 478
    property int deleteHeaderLeftMargin: 771
    property int fontSize: 14

    property int listviewClickIndex: -1
    property bool isAllSelect: false

    signal s_allselect(bool isSelect);

    WarnModel{
        id:warnmodel
        // Component.objectName: warnmodel.flushWarnInfo(deviceconfig.getScrennShotPath());
    }


    Rectangle{
        id:rectWarnArea
        width: parent.width-40
        height: parent.height-40
        anchors.verticalCenter: parent.verticalCenter
        anchors.horizontalCenter: parent.horizontalCenter
        color: "#F8FAFD"


        //第一排控件
        Text {
            id: textitle
            anchors.left: parent.left
            anchors.top: parent.top
            anchors.leftMargin: 60
            anchors.topMargin: 35
            font.pixelSize: 18
            text: qsTr("日志列表")
        }

        Rectangle{
            id:rectBatch
            width: 96
            height: 36
            color: "#66B5FF"
            radius: 4
            anchors.left: textitle.right
            anchors.leftMargin: 39
            anchors.verticalCenter: textitle.verticalCenter

            Image {
                id: imgBatchDelete
                width: 14
                height: 15
                anchors.left: parent.left
                anchors.leftMargin: 9
                anchors.verticalCenter: parent.verticalCenter
                source: "qrc:/images/imgDelete.png"

            }

            Text {
                id: txtBatchDelete
                font.pixelSize: fontSize
                anchors.left: imgBatchDelete.right
                anchors.leftMargin: 9
                anchors.verticalCenter: parent.verticalCenter
                color: "#ffffff"
                text: qsTr("批量删除")
            }
            MouseArea{
                anchors.fill: parent

                onClicked: {

                    askDialog.width = 427
                    askDialog.height = 176
                    askDialog.askStr = qsTr("确认要删除所选信息吗？")
                    askDialog.imgSrc = "qrc:/images/ico_warn.png"
                    askDialog.curType = askDialog.warnInfoMutipleDelete
                    askDialog.open();

                }
                onPressed: rectBatch.color = "#3B84F6"
                onReleased: rectBatch.color = "#66B5FF"
            }
        }

        //日期选择
        Rectangle{

            id:dateRect
            color: "#ffffff"
            border.width: 1
            border.color: "#DCDFE6"
            radius: 4
            width: 190
            height: 34
            anchors.verticalCenter: rectBatch.verticalCenter
            anchors.right: parent.right
            anchors.rightMargin: 190

            Image {
                id: imgdate
                width: 14
                height: 13
                source: "qrc:/images/data1.png"
                anchors.left: parent.left
                anchors.verticalCenter: parent.verticalCenter
                anchors.leftMargin: 10
            }

            Text {
                id: txtDate
                anchors.left: imgdate.right
                anchors.leftMargin: 10
                anchors.verticalCenter: parent.verticalCenter
                font.pixelSize: fontSize
                color: "#909399"
                text:""
            }
            MouseArea{
                anchors.fill: parent
                hoverEnabled: true
                onPressed: {
                    calendar.open()
                }
                onEntered: imgdate.source = "qrc:/images/data1.png"
                onReleased: imgdate.source = "qrc:/images/data1.png"
            }

        }




        //时间选择
        Rectangle{

            id:timeRect
            color: "#ffffff"
            border.width: 1
            border.color: "#DCDFE6"
            radius: 4
            width: 120
            height: 34
            z:2
            anchors.left: dateRect.right
            anchors.verticalCenter: rectBatch.verticalCenter
            anchors.leftMargin: 10

            Image {
                id: imgtime
                width: 14
                height: 14
                source: "qrc:/images/time.png"
                anchors.left: parent.left
                anchors.verticalCenter: parent.verticalCenter
                anchors.leftMargin: 10
            }

            Text {
                id: txttime
                anchors.left: imgtime.right
                anchors.leftMargin: 10
                anchors.verticalCenter: parent.verticalCenter
                font.pixelSize: fontSize
                color: "#909399"
                text: qsTr("")
            }
            MouseArea{
                anchors.fill: parent
                hoverEnabled: true
                onPressed: {
                    selecttime.visible = true
                }
                onEntered: imgtime.source = "qrc:/images/time.png"
                onReleased: imgtime.source = "qrc:/images/time.png"
            }

        }

        //警报列表
        Rectangle{
            id:warnHeader
            width: parent.width -120
            height: 50
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: parent.top
            anchors.topMargin: 84
            z:1
            color: "#EEF3FA"
            Image{
                id:imgSelect
                width: 14
                height: 14
                anchors.verticalCenter: parent.verticalCenter
                anchors.left: parent.left
                anchors.leftMargin: checkedHeaderLeftMargin
                source: "qrc:/images/btnSelect.png"

                MouseArea{
                    anchors.fill: parent
                    onClicked: {
                        if(isAllSelect){
                            imgSelect.source ="qrc:/images/btnSelect.png"
                            isAllSelect = false;
                        }else{
                            imgSelect.source ="qrc:/images/btnSelect_s.png"
                            isAllSelect = true;
                        }
                        warnmodel.funSetAllSelect(isAllSelect);
                    }
                }
            }
            Text {
                id: txtWarnTime
                anchors.verticalCenter: parent.verticalCenter
                anchors.left: parent.left
                anchors.leftMargin: warnTimeHeaderLeftMargin
                font.pixelSize: fontSize
                text: qsTr("告警时间")
            }
            Text {
                id: txtWarnTemp
                anchors.verticalCenter: parent.verticalCenter
                anchors.left: parent.left
                anchors.leftMargin: warnTempHeaderLeftMargin
                font.pixelSize: fontSize
                text: qsTr("告警温度")
            }
            Text {
                id: warnImg
                anchors.verticalCenter: parent.verticalCenter
                anchors.left: parent.left
                anchors.leftMargin: warnImgHeaderLeftMargin
                font.pixelSize: fontSize
                text: qsTr("抓拍图片")
            }
            Text {
                id: txtDelete
                anchors.verticalCenter: parent.verticalCenter
                anchors.left: parent.left
                anchors.leftMargin: deleteHeaderLeftMargin
                font.pixelSize: fontSize
                text: qsTr("操作")
            }
        }
        ListView{
            id:warnList
            width: warnHeader.width
            height: parent.height - 210 -warnHeader.height
            anchors.top: warnHeader.bottom
            anchors.left: warnHeader.left
            model: warnmodel
            z:0
            ScrollBar.vertical: ScrollBar {size:10}
            delegate: Rectangle{
                property bool enter: false
                width: parent.width
                height: 59
                color:listviewClickIndex === index?"#EEF3FA":(enter?"#EEF3FA":"#F8FAFD")
                Image{
                    id:select
                    width: 14
                    height: 14
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.left: parent.left
                    anchors.leftMargin: checkedHeaderLeftMargin
                    source:model.isSelect>0?"qrc:/images/btnSelect_s.png": "qrc:/images/btnSelect.png"
                    MouseArea{
                        anchors.fill: parent
                        onClicked: {
                            model.isSelect = !model.isSelect;
                        }
                    }
                }
                Text {
                    id: warnTime
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.left: parent.left
                    anchors.leftMargin: warnTimeHeaderLeftMargin
                    font.pixelSize: fontSize
                    text: model.warnTime;
                }
                Text {
                    id: warnTemp
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.left: parent.left
                    anchors.leftMargin: warnTempHeaderLeftMargin
                    font.pixelSize: fontSize
                    text: model.warnTemp;
                }

                Image {
                    id: captureImg
                    width: 13
                    height: 14
                    anchors.left: parent.left
                    anchors.leftMargin: warnImgHeaderLeftMargin
                    anchors.verticalCenter: parent.verticalCenter
                    source: index === listviewClickIndex?"qrc:/images/capture_p.png":"qrc:/images/capture.png"
                }
                Text {
                    id: captureTxt
                    anchors.left: captureImg.right
                    anchors.leftMargin: 7
                    anchors.verticalCenter: parent.verticalCenter
                    font.pixelSize: fontSize
                    color: index === listviewClickIndex?"#3B84F6":"#333333"
                    text: model.imgName;
                    MouseArea{
                        anchors.fill: parent
                        onClicked:{
                            console.debug("absolutePath:"+model.absolutePath)
                            imgshow.source ="file:///"+ model.absolutePath
                            imgpop.open();
                        }
                    }
                }


                Text {
                    id: deletetxt
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.left: parent.left
                    anchors.leftMargin: deleteHeaderLeftMargin
                    font.pixelSize: fontSize
                    color: "#3B84F6"
                    text: qsTr("删除")
                    MouseArea{
                        anchors.fill: parent
                        onClicked: {
                            askDialog.width = 427
                            askDialog.height = 176
                            askDialog.askStr = qsTr("确认删除信息吗？")
                            askDialog.imgSrc = "qrc:/images/ico_warn.png"
                            askDialog.curType = askDialog.warnInfoSingleDelete
                            askDialog.open();
                           // warnmodel.funDeleteIndex(index);
                        }
                    }
                }

                MouseArea{
                    anchors.fill: parent
                    hoverEnabled: true
                    propagateComposedEvents:true
                    onEntered:enter = true
                    onExited: enter = false;
                    onClicked: {

                        listviewClickIndex = index;
                        mouse.accepted = false
                    }
                }
            }
        }
        MyCalendar{
            id:calendar
            width: 280
            height: 314
            dim:false
            x:dateRect.x
            y:67
            onS_dayChange:warnmodel.funFlushWarnInfo(deviceconfig.getScrennShotPath(),value);

            onS_dayChange1: txtDate.text = value


            //onS_mouthChange:getRecordInfo(1,value)

            onS_yearChange: ;

            // Component.onCompleted:getRecordInfo(2, Qt.formatDate(calendar.getCurrentData(),"yyyyMMdd000000"))
        }

        SelectTime{
            id:selecttime
            anchors.left: timeRect.left
            anchors.top: timeRect.bottom
            z:1
            width: 120
            height: 245
            onS_ensure: {
                var timeStr = timeh+":"+timem+":"+times
                txttime.text = timeStr
                var curIndex = warnmodel.funFindIndex(timeh,timem,times)
                console.debug("curIndex "+curIndex)

                warnList.positionViewAtIndex(curIndex,ListView.Beginning)
                //warnList.currentIndex = curIndex
            }

        }
    }



    Popup {
        id: imgpop
        x:(parent.width-720)/2
        y:(parent.height-520)/2
        width: 720
        height: 520
        modal: true
        focus: true
        //设置窗口关闭方式为按“Esc”键关闭
        closePolicy: Popup.CloseOnEscape|Popup.CloseOnPressOutside
        //设置窗口的背景控件，不设置的话Popup的边框会显示出来
        background: rect

        Rectangle{
            id:rect
            color: "#00000000"
            anchors.fill: parent
            Image {
                id: imgshow
                width: 600
                height: 400
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.verticalCenter: parent.verticalCenter
                source: ""
            }

            Image {
                id: imgclose
                width: 40
                height: 40
                anchors.left: imgshow.right
                anchors.bottom: imgshow.top
                anchors.leftMargin: 20
                anchors.bottomMargin: 20
                source: "qrc:/images/img_close.png"
                MouseArea{
                    anchors.fill: parent
                    onClicked: imgpop.close();
                }
            }

        }
    }


    Connections{
        target: askDialog
        onS_CurTypeMsg:{
            if(askDialog.warnInfoMutipleDelete === type)
                warnmodel.funDeleteSelect();
            else if(askDialog.warnInfoSingleDelete === type)
                warnmodel.funDeleteIndex(listviewClickIndex)
        }
    }


}

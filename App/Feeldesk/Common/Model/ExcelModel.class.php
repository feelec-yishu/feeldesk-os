<?php
// +----------------------------------------------------------------------
// | FeelDesk-DEV开源工单管理系统
// +----------------------------------------------------------------------
// | 欢迎阅读学习系统程序代码，您的建议反馈是我们前进的动力
// | 开源版本仅供技术交流学习，请务必保留界面版权logo
// | 商业版本务必购买商业授权，以免引起法律纠纷
// | 禁止对系统程序代码以任何目的，任何形式的再发布
// | gitee下载：https://gitee.com/feelecs/feeldesk-os
// | 开源官网：https://www.feeldesk.com.cn
// | 成都菲莱克斯科技有限公司 版权所有 拥有最终解释权
// +----------------------------------------------------------------------
namespace Common\Model;

use Think\Csv;
use Think\Model;

class ExcelModel extends Model
{
    protected $autoCheckFields = false;



    public function getDataAnalysis($data,$tableHeader,$value,$name,$filename)
    {
        $str = "ABCDEFGHIJKLMNOPQRSTUVWXYZ";

        $excelData = [];

        $status_num = count($data['status']);

        $letter = ['A','B'];

//        表头数组
        for($j=0;$j<$status_num;$j++)
        {
//            Excel表格式,根据状态数量决定列表格式
            $letter[$j+2] = substr($str,$j+2,1);

            $tableHeader[$j+2] = $data['status'][$j]['lang_name'];

        }

//        表格数组，数据内容
        foreach($data[$value] as $ck=>$cv)
        {
            $tempData[$ck] = [
                $cv[$name],
                $cv['ticket_num'] ? $cv['ticket_num'] : 0
            ];

            foreach($cv['status'] as &$cs)
            {
                $cs = $cs." (".getPercentage($cv['ticket_num'] ? $cv['ticket_num'] : 0,$cs).")";
            }

            foreach($tempData as $v)
            {
                $excelData[$ck] = array_merge($v,$cv['status']);
            }
        }

//        合计
        $a = 1;

        $total_num = $data['total']['ticket_num'];

        $total_status = $data['total']['status'];

        $totalData[0] = [L('TOTAL'),$total_num];

        foreach($total_status as &$v2)
        {
            $a++;

            $totalData[0][$a] = $v2." (".getPercentage($total_num ? $total_num : 0,$v2).")";
        }

        $excelData = array_merge($excelData,$totalData);

        if($value == 'channel')
        {
            foreach($excelData as &$v)
            {
                if($v[0] == 'PC')  $v[0] = 'PC';

            }
        }

	    $filename = $filename.'-'.date('ymdhis').".csv";

	    $csv = new Csv();

	    $csv->exportCsv($excelData,$tableHeader,$filename);
/*
	    $filename = $filename.".xls";

	    $this->exportExcel($filename,$tableHeader,$letter,$excelData);
*/
    }



    /*
    * 输出Excel文件
    * @param   string  $filename       文件名称
    * @param   array   $tableHeader    表头数据
    * @param   array   $letter         列表标识 A B C D
    * @param   array   $excelData      表格数据
    */
    public function exportExcel($filename,$tableHeader,$letter,$excelData,$source='')
    {
        import('Org.Util.PHPExcel');//手动加载第三方插件

        $excel = new \PHPExcel();

        $objActSheet = $excel->getActiveSheet();

//        填充表头信息
        for($t = 0;$t < count($tableHeader);$t++)
        {
//            设置表头数据
            $objActSheet->setCellValue("$letter[$t]1","$tableHeader[$t]");

//            设置列宽
            $objActSheet->getColumnDimension("$letter[$t]")->setWidth('25');

//            文本居中
            $objActSheet->getStyle("$letter[$t]1")->getAlignment()->setHorizontal(\PHPExcel_Style_Alignment::HORIZONTAL_CENTER);

//            加粗
            $objActSheet->getStyle("$letter[$t]1")->applyFromArray(['font'=> ['bold'=> true]]);

//            行高
            $objActSheet->getRowDimension(1)->setRowHeight('30');

//            垂直居中
            $objActSheet->getStyle("$letter[$t]1")->getAlignment()->setVertical(\PHPExcel_Style_Alignment::VERTICAL_CENTER);
        }

//        填充表格信息
        for($i = 2;$i <= count($excelData)+1;$i++)
        {
            $l = 0;

            foreach($excelData[$i - 2] as $key=>$value)
            {
                //设置单元格数据
                $objActSheet->setCellValue("$letter[$l]$i","$value");

                //文本居中
                $objActSheet->getStyle("$letter[$l]$i")->getAlignment()->setHorizontal(\PHPExcel_Style_Alignment::HORIZONTAL_CENTER);

                //设置行高
                $objActSheet->getRowDimension($i)->setRowHeight('20');

                //垂直居中
                $objActSheet->getStyle("$letter[$l]$i")->getAlignment()->setVertical(\PHPExcel_Style_Alignment::VERTICAL_CENTER);

                if($i == count($excelData)+1 && $source != 'ticket')
                {
                    //行高
                    $objActSheet->getRowDimension($i)->setRowHeight('30');

                    //加粗
                    $objActSheet->getStyle("$letter[$l]$i")->applyFromArray(['font'=> ['bold'=> true]]);
                }

                $l++;
            }
        }

//        创建Excel输入对象
        $write = new \PHPExcel_Writer_Excel5($excel);

        header("Pragma: public");

        header("Expires: 0");

        header("Cache-Control:must-revalidate, post-check=0, pre-check=0");

        header("Content-Type:application/force-download");

        header("Content-Type:application/vnd.ms-execl");

        header("Content-Type:application/octet-stream");

        header("Content-Type:application/download");;

        header('Content-Disposition:attachment;filename='.$filename);

        header("Content-Transfer-Encoding:binary");

        $write->save('php://output');
    }

	 /*
    * 输出Excel文件
    * @param   string  $filename       文件名称
    * @param   array   $tableHeader    表头数据
    * @param   array   $letter         列表标识 A B C D
    * @param   array   $excelData      表格数据
    * @param   array   $merage         要合并的单元格
    */
    public function exportExcelShipment($filename,$tableHeader1,$tableHeader2,$letter1,$letter2,$excelData,$merage,$source='')
    {
        import('Org.Util.PHPExcel');//手动加载第三方插件

        $excel = new \PHPExcel();

        $objActSheet = $excel->getActiveSheet();

		foreach($merage as $val)
		{
			$objActSheet->mergeCells("$val[0]1:$val[1]1"); //合并单元格
		}

//        填充表头信息
        for($t = 0;$t < count($tableHeader1);$t++)
        {
//            设置表头数据
            $objActSheet->setCellValue("$letter1[$t]1","$tableHeader1[$t]");

//            设置列宽
            $objActSheet->getColumnDimension("$letter1[$t]")->setWidth('25');

//            文本居中
            $objActSheet->getStyle("$letter1[$t]1")->getAlignment()->setHorizontal(\PHPExcel_Style_Alignment::HORIZONTAL_CENTER);

//            加粗
            $objActSheet->getStyle("$letter1[$t]1")->applyFromArray(['font'=> ['bold'=> true]]);

//            行高
            $objActSheet->getRowDimension(1)->setRowHeight('30');

//            垂直居中
            $objActSheet->getStyle("$letter1[$t]1")->getAlignment()->setVertical(\PHPExcel_Style_Alignment::VERTICAL_CENTER);
        }

		for($t = 0;$t < count($tableHeader2);$t++)
        {
//            设置表头数据
            $objActSheet->setCellValue("$letter2[$t]2","$tableHeader2[$t]");

//            设置列宽
            $objActSheet->getColumnDimension("$letter2[$t]")->setWidth('25');

//            文本居中
            $objActSheet->getStyle("$letter2[$t]2")->getAlignment()->setHorizontal(\PHPExcel_Style_Alignment::HORIZONTAL_CENTER);

//            加粗
            $objActSheet->getStyle("$letter2[$t]2")->applyFromArray(['font'=> ['bold'=> true]]);

//            行高
            $objActSheet->getRowDimension(2)->setRowHeight('30');

//            垂直居中
            $objActSheet->getStyle("$letter2[$t]2")->getAlignment()->setVertical(\PHPExcel_Style_Alignment::VERTICAL_CENTER);
        }

//        填充表格信息
        for($i = 3;$i <= count($excelData)+2;$i++)
        {
            $l = 0;

            foreach($excelData[$i - 3] as $key=>$value)
            {
                //设置单元格数据
                $objActSheet->setCellValue("$letter2[$l]$i","$value");

                //文本居中
                $objActSheet->getStyle("$letter2[$l]$i")->getAlignment()->setHorizontal(\PHPExcel_Style_Alignment::HORIZONTAL_CENTER);

                //设置行高
                $objActSheet->getRowDimension($i)->setRowHeight('20');

                //垂直居中
                $objActSheet->getStyle("$letter2[$l]$i")->getAlignment()->setVertical(\PHPExcel_Style_Alignment::VERTICAL_CENTER);

                if($i == count($excelData)+1 && $source != 'ticket')
                {
                    //行高
                    $objActSheet->getRowDimension($i)->setRowHeight('30');

                    //加粗
                    $objActSheet->getStyle("$letter2[$l]$i")->applyFromArray(['font'=> ['bold'=> true]]);
                }

                $l++;
            }
        }

//        创建Excel输入对象
        $write = new \PHPExcel_Writer_Excel5($excel);

        header("Pragma: public");

        header("Expires: 0");

        header("Cache-Control:must-revalidate, post-check=0, pre-check=0");

        header("Content-Type:application/force-download");

        header("Content-Type:application/vnd.ms-execl");

        header("Content-Type:application/octet-stream");

        header("Content-Type:application/download");;

        header('Content-Disposition:attachment;filename='.$filename);

        header("Content-Transfer-Encoding:binary");

        $write->save('php://output');
    }
}

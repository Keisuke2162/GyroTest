//
//  ViewController.swift
//  GyroTest
//
//  Created by 植田圭祐 on 2019/05/12.
//  Copyright © 2019 Keisuke Ueda. All rights reserved.
//

import UIKit
import CoreMotion
import Charts

class ViewController: UIViewController {
    
    //加速度表示ラベル
    @IBOutlet weak var xAxis: UILabel!
    @IBOutlet weak var yAxis: UILabel!
    @IBOutlet weak var zAxis: UILabel!
    
    //加速度格納配列
    var xDataArray = [Double]()
    var yDataArray = [Double]()
    var zDataArray = [Double]()
    
    //グラフ表示用View
    @IBOutlet weak var xLineChart: LineChartView!
    @IBOutlet weak var yLineChart: LineChartView!
    @IBOutlet weak var zLineChart: LineChartView!
    
    //CMMotionManagerインスタンス化
    var motionManager = CMMotionManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    //viewDidLoad後に処理される
    override func viewDidAppear(_ animated: Bool) {
        
        //加速度センサ値取得間隔（sec）
        motionManager.gyroUpdateInterval = 0.1
        
        //センサー値取得処理
        motionManager.startGyroUpdates(to: OperationQueue.current!){ (data, error) in
            
            //アンラップ
            if let data = data {
                
                //加速度を求める
                let xData = data.rotationRate.x * 180 / Double.pi
                let yData = data.rotationRate.y * 180 / Double.pi
                let zData = data.rotationRate.z * 180 / Double.pi
                
                //求めた加速度を配列に格納
                self.xDataArray.append(xData)
                self.yDataArray.append(yData)
                self.zDataArray.append(zData)
                
                //配列の要素が10を超えたら先頭の要素を削除
                if self.xDataArray.count >= 10 {
                    self.xDataArray.removeFirst()
                }
                
                if self.yDataArray.count >= 10 {
                    self.yDataArray.removeFirst()
                }
                
                if self.zDataArray.count >= 10 {
                    self.zDataArray.removeFirst()
                }
                
                //加速度表示ラベルに値を表示
                self.xAxis.text = "\(xData)"
                self.yAxis.text = "\(yData)"
                self.zAxis.text = "\(zData)"
                
                //x,y,zそれぞれのグラフ描画処理へGO
                self.xSetChart(values: self.xDataArray)
                self.ySetChart(values: self.yDataArray)
                self.zSetChart(values: self.zDataArray)
                
            }
        }
    }
    
    //xグラフ描画処理
    func xSetChart(values: [Double]) {
        
        //ChartDataEntry型の配列を宣言
        var entry = [ChartDataEntry]()
        
        //グラフ用データ配列に加速度データを格納
        for i in 0..<values.count {
            //xにデータの値(i)、yに加速度のデータを格納
            entry.append(ChartDataEntry(x: Double(i), y: values[i] ))
        }
        
        //グラフの種類(棒グラフ)、棒グラフの関節の色と大きさを設定
        let dataSet = LineChartDataSet(entries: entry, label: nil)
        dataSet.colors = [UIColor.blue]
        dataSet.circleRadius = 4
        dataSet.circleColors = [UIColor.purple]
        //グラフ用Viewの背景色設定
        xLineChart.backgroundColor = UIColor.lightGray.withAlphaComponent(0.50)
        
        //グラフのタイトルを設定？（正直よくわかってない）
        let xLocat = xLineChart.xAxis
        xLocat.valueFormatter = IndexAxisValueFormatter(values: ["test"])
        
        //Viewにグラフを描画
        xLineChart.data = LineChartData(dataSet: dataSet)
    }
    
    
    func ySetChart(values: [Double]) {
        //ChartDataEntry型の配列を宣言
        var entry = [ChartDataEntry]()
        
        for i in 0..<values.count {
            //xにデータの値、yに横軸の値のセットを配列に追加
            entry.append(ChartDataEntry(x: Double(i), y: values[i] ))
        }
        
        let dataSet = LineChartDataSet(entries: entry, label: nil)
        dataSet.colors = [UIColor.blue]
        dataSet.circleRadius = 4
        dataSet.circleColors = [UIColor.purple]
        
        yLineChart.backgroundColor = UIColor.lightGray.withAlphaComponent(0.50)
        
        let yLocat = yLineChart.xAxis
        yLocat.valueFormatter = IndexAxisValueFormatter(values: ["test"])
        //Viewにグラフを描画
        yLineChart.data = LineChartData(dataSet: dataSet)
    }
    
    
    func zSetChart(values: [Double]) {
        //ChartDataEntry型の配列を宣言
        var entry = [ChartDataEntry]()
        
        for i in 0..<values.count {
            //xにデータの値、yに横軸の値のセットを配列に追加
            entry.append(ChartDataEntry(x: Double(i), y: values[i] ))
        }
        
        let dataSet = LineChartDataSet(entries: entry, label: nil)
        dataSet.colors = [UIColor.blue]
        dataSet.circleRadius = 4
        dataSet.circleColors = [UIColor.purple]
        
        zLineChart.backgroundColor = UIColor.lightGray.withAlphaComponent(0.50)
        
        let zLocat = zLineChart.xAxis
        zLocat.valueFormatter = IndexAxisValueFormatter(values: ["test"])
        //Viewにグラフを描画
        zLineChart.data = LineChartData(dataSet: dataSet)
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}


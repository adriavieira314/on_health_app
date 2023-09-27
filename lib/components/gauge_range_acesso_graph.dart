import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

class GaugeRangeAcessoGraph extends StatelessWidget {
  final double? value;

  const GaugeRangeAcessoGraph({super.key, this.value});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 280,
      height: 280,
      child: SfRadialGauge(
        axes: <RadialAxis>[
          RadialAxis(
              interval: 1,
              showFirstLabel: false,
              startAngle: 270,
              endAngle: 270,
              showLabels: false,
              showAxisLine: false,
              showTicks: false,
              // minimum: 0,
              // maximum: 100,
              ranges: <GaugeRange>[
                GaugeRange(
                  startValue: 0,
                  endValue: 100,
                  color: Colors.grey[300],
                  sizeUnit: GaugeSizeUnit.factor,
                  startWidth: 0.05,
                  endWidth: 0.05,
                ),
              ],
              pointers: <GaugePointer>[
                if (value! <= 56)
                  RangePointer(
                    value: value!.toDouble(),
                    color: Colors.red,
                    pointerOffset: 10,
                    width: 20,
                  ),
                if (value! > 56)
                  RangePointer(
                    value: value!.toDouble(),
                    color: Colors.green,
                    pointerOffset: 10,
                    width: 20,
                  ),
              ],
              annotations: <GaugeAnnotation>[
                GaugeAnnotation(
                  axisValue: 50,
                  positionFactor: 0,
                  widget: Text(
                    '$value%',
                    style: TextStyle(fontSize: 20),
                  ),
                ),
              ])
        ],
      ),
    );
  }
}

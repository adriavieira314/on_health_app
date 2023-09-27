import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

class GaugeRangeDcntGraph extends StatelessWidget {
  final double? value;

  const GaugeRangeDcntGraph({super.key, this.value});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 280,
      height: 280,
      child: SfRadialGauge(
        axes: <RadialAxis>[
          RadialAxis(
            showLabels: false,
            showAxisLine: false,
            showTicks: false,
            minimum: 0,
            maximum: 100,
            startAngle: 180,
            endAngle: 0,
            ranges: <GaugeRange>[
              GaugeRange(
                startValue: 0,
                endValue: 20,
                color: const Color(0xFFFE2A25),
                sizeUnit: GaugeSizeUnit.factor,
                startWidth: 0.20,
                endWidth: 0.20,
              ),
              GaugeRange(
                startValue: 18,
                endValue: 30,
                color: const Color(0xFFFFBA00),
                startWidth: 0.20,
                endWidth: 0.20,
                sizeUnit: GaugeSizeUnit.factor,
              ),
              GaugeRange(
                startValue: 30,
                endValue: 45,
                color: const Color(0xFF00AB47),
                sizeUnit: GaugeSizeUnit.factor,
                startWidth: 0.20,
                endWidth: 0.20,
              ),
              GaugeRange(
                startValue: 45,
                endValue: 100,
                color: Colors.blue,
                sizeUnit: GaugeSizeUnit.factor,
                startWidth: 0.20,
                endWidth: 0.20,
              ),
            ],
            pointers: <GaugePointer>[
              NeedlePointer(
                value: value ?? 0.0,
                needleStartWidth: 1,
                needleEndWidth: 5,
                knobStyle: const KnobStyle(
                  knobRadius: 0.05,
                  borderColor: Colors.black,
                  borderWidth: 0.02,
                  color: Colors.white,
                ),
              ),
            ],
            annotations: <GaugeAnnotation>[
              GaugeAnnotation(
                angle: 90,
                positionFactor: 0.2,
                widget: Text(
                  '$value%',
                  style: const TextStyle(
                    fontSize: 20,
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}

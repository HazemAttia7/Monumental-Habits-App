import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pixel_true_app/core/enums/subscription_enums.dart';
import 'package:pixel_true_app/features/subscription/presentation/views/widgets/plan_widget.dart';

class PlansSection extends StatefulWidget {
  const PlansSection({super.key});

  @override
  State<PlansSection> createState() => _PlansSectionState();
}

class _PlansSectionState extends State<PlansSection> {
  enPlanType _planType = enPlanType.yearly;

  void setPlanType(enPlanType planType) => setState(() => _planType = planType);

  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: 10.w,
      children: [
        Expanded(
          child: PlanWidget(
            isSelected: _planType == enPlanType.monthly,
            price: 19,
            planType: enPlanType.monthly,
            onTap: () => setPlanType(enPlanType.monthly),
          ),
        ),
        Expanded(
          child: PlanWidget(
            isSelected: _planType == enPlanType.yearly,
            price: 29,
            planType: enPlanType.yearly,
            onTap: () => setPlanType(enPlanType.yearly),
          ),
        ),
        Expanded(
          child: PlanWidget(
            isSelected: _planType == enPlanType.lifetime,
            price: 49,
            planType: enPlanType.lifetime,
            discountPercentage: 75,
            onTap: () => setPlanType(enPlanType.lifetime),
          ),
        ),
      ],
    );
  }
}

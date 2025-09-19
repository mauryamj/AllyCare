import 'package:flutter/material.dart';

class AssesmentDetailScreen extends StatelessWidget {
  const AssesmentDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(leading: const BackButton(), backgroundColor: Colors.transparent, elevation: 0),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          ClipRRect(borderRadius: BorderRadius.circular(16), child: Container(height: 180, width: double.infinity, color: Colors.grey[300], child: const Center(child: Text("Assessment Image")))),
          const SizedBox(height: 16),
          const Text("Health Risk Assessment", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          const SizedBox(height: 6),
          Text("⏱ 4 min", style: TextStyle(color: Colors.grey[600])),
          const SizedBox(height: 20),
          const Text("What do you get?", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
          const SizedBox(height: 12),
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: const [
            _IconInfo(icon: Icons.favorite, label: "Vitals"),
            _IconInfo(icon: Icons.accessibility, label: "Posture"),
            _IconInfo(icon: Icons.fitness_center, label: "Composition"),
            _IconInfo(icon: Icons.insert_chart, label: "Reports"),
          ]),
          const SizedBox(height: 20),
          const Text("How we do it?", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
          const SizedBox(height: 12),
          ClipRRect(borderRadius: BorderRadius.circular(12), child: Container(height: 160, width: double.infinity, color: Colors.grey[300], child: const Center(child: Text("How we do it image")))),
          const SizedBox(height: 12),
          Container(padding: const EdgeInsets.all(12), decoration: BoxDecoration(color: Colors.green.shade50, borderRadius: BorderRadius.circular(12)), child: Row(children: const [Icon(Icons.verified_user, color: Colors.green), SizedBox(width: 8), Expanded(child: Text("We do not store or share your personal data"))])),
          const SizedBox(height: 12),
          const Text("Benefits", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
          const SizedBox(height: 12),
          const _BulletPoint(text: "Holistic insight into physical health"),
          const _BulletPoint(text: "Enables early interventions"),
          const _BulletPoint(text: "Tailored lifestyle recommendations"),
          const SizedBox(height: 24),
          SizedBox(width: double.infinity, child: ElevatedButton(onPressed: () {}, style: ElevatedButton.styleFrom(backgroundColor: Colors.blue.shade800, padding: const EdgeInsets.symmetric(vertical: 16), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30))), child: const Text("Start Assessment", style: TextStyle(fontSize: 16)))),
        ]),
      ),
    );
  }
}

class _IconInfo extends StatelessWidget {
  final IconData icon;
  final String label;
  const _IconInfo({required this.icon, required this.label});
  @override
  Widget build(BuildContext context) {
    return Column(children: [CircleAvatar(radius: 26, backgroundColor: Colors.blue.shade50, child: Icon(icon, color: Colors.blue.shade800)), const SizedBox(height: 6), Text(label, textAlign: TextAlign.center, style: const TextStyle(fontSize: 12))]);
  }
}

class _BulletPoint extends StatelessWidget {
  final String text;
  const _BulletPoint({required this.text});
  @override
  Widget build(BuildContext context) {
    return Padding(padding: const EdgeInsets.symmetric(vertical: 6), child: Row(children: [const Icon(Icons.check, size: 18, color: Colors.blue), const SizedBox(width: 8), Expanded(child: Text(text))]));
  }
}

import math
import unittest

from MayaCraft.domain.bendy_deformation import sample_bendy_arc


def dot(left, right):
    return sum(a * b for a, b in zip(left, right))


class BendyDeformationTests(unittest.TestCase):
    def test_straight_arc_is_even_and_orthonormal(self):
        arc = sample_bendy_arc(((0, 0, 0), (3, 0, 0), (7, 0, 0), (10, 0, 0)), 6)
        self.assertAlmostEqual(arc.arc_length, 10.0, places=6)
        self.assertAlmostEqual(arc.stretch_ratio, 1.0, places=6)
        for index, sample in enumerate(arc.samples):
            self.assertAlmostEqual(sample.position[0], index * 2.0, places=4)
            self.assertAlmostEqual(dot(sample.tangent, sample.normal), 0.0, places=7)
            self.assertAlmostEqual(dot(sample.tangent, sample.binormal), 0.0, places=7)
            self.assertAlmostEqual(sample.volume_scale, 1.0, places=7)

    def test_c_arc_uses_equal_distance_not_equal_parameter(self):
        arc = sample_bendy_arc(((0, 0, 0), (1, 6, 0), (8, 5, 0), (10, 0, 0)), 9)
        distances = [math.dist(left.position, right.position)
                     for left, right in zip(arc.samples, arc.samples[1:])]
        self.assertLess(max(distances) - min(distances), 0.08)
        self.assertGreater(arc.arc_length, arc.chord_length)
        self.assertLess(arc.samples[0].volume_scale, 1.0)

    def test_s_arc_frames_do_not_flip(self):
        arc = sample_bendy_arc(((0, 0, 0), (3, 7, 0), (7, -7, 0), (10, 0, 0)), 21)
        for left, right in zip(arc.samples, arc.samples[1:]):
            self.assertGreater(dot(left.normal, right.normal), 0.8)
            self.assertGreater(dot(left.binormal, right.binormal), 0.8)

    def test_nearly_parallel_up_hint_falls_back_cleanly(self):
        arc = sample_bendy_arc(
            ((0, 0, 0), (2, 0, 0), (4, 0.001, 0), (6, 0, 0)),
            5, up_hint=(1, 0, 0),
        )
        self.assertEqual(len(arc.samples), 5)
        self.assertTrue(all(abs(dot(sample.tangent, sample.normal)) < 1e-7
                            for sample in arc.samples))

    def test_invalid_arc_is_blocked_before_host_work(self):
        with self.assertRaisesRegex(ValueError, "起点与终点"):
            sample_bendy_arc(((0, 0, 0), (1, 0, 0), (1, 1, 0), (0, 0, 0)))
        with self.assertRaisesRegex(ValueError, "体积保持"):
            sample_bendy_arc(((0, 0, 0), (1, 0, 0), (2, 0, 0), (3, 0, 0)),
                             volume_preservation=2.0)


if __name__ == "__main__":
    unittest.main()

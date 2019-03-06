function [] = demo_function()

harris_corner_detector("person_toy/00000001.jpg", 0.04, 0, 1);
harris_corner_detector("person_toy/00000001.jpg", 0.2, 0, 1);
harris_corner_detector("pingpong/0000.jpeg", 0.04, 0, 1);
harris_corner_detector("pingpong/0000.jpeg", 0.2, 0, 1);

harris_corner_detector("person_toy/00000001.jpg", 0.04, 45, 1);
harris_corner_detector("person_toy/00000001.jpg", 0.04, 90, 1);

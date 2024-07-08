#ifndef COMMON_H
#define COMMON_H

#include <iostream>
#include <map>
#include <string>

std::map<std::string, int> CYCLE_COUNTS;

void register_module(const char *path_c) {
  std::string path(path_c);
  CYCLE_COUNTS[path] = 0;
}

void increment_cycle_count(const char *path_c) {
  std::string path(path_c);
  CYCLE_COUNTS[path] += 1;
}

#endif /* COMMON_H */

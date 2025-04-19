#ifndef STRINGOPS_H
#define STRINGOPS_H


#include <stdlib.h>
#include <stdio.h>
#include <string.h>
#include <stddef.h>
#include <stdbool.h>

typedef struct {
    const char *data;
    size_t      len;
} string;

static inline bool strings_equal(const string *l, const string *r) {
    if (l->len != r->len) return false;
    return memcmp(l->data, r->data, l->len) == 0;
}




string string_from_cstr(const char *str) {
    string s;
    s.len  = strlen(str);
    s.data = str;
    return s;
}

typedef struct {
    const char *start;
    size_t      len;
} string_view;

typedef struct {
    string_view *splits;
    size_t       count;
    size_t       capacity;
} string_splits;

static string_splits split_string(const char *str, char split_by) {
    size_t len = strlen(str);
    string_splits result;
    result.count    = 0;
    result.capacity = 8;
    result.splits   = (string_view*) calloc(result.capacity, sizeof(string_view));
    if (!result.splits) {
        perror("calloc");
        exit(EXIT_FAILURE);
    }

    const char *token_start = str;
    for (size_t i = 0; i < len; ++i) {
        if (str[i] == split_by) {
            if (result.count >= result.capacity) {
                result.capacity *= 2;
                string_view *tmp =  (string_view*)realloc(result.splits, result.capacity * sizeof(string_view));
                if (!tmp) {
                    perror("realloc");
                    free(result.splits);
                    exit(EXIT_FAILURE);
                }
                result.splits = tmp;
            }
            result.splits[result.count].start = token_start;
            result.splits[result.count].len   = &str[i] - token_start;
            result.count++;
            token_start = &str[i + 1];
        }
    }

    // Add final token
    if (token_start <= str + len) {
        if (result.count >= result.capacity) {
            result.capacity *= 2;
            string_view *tmp = realloc(result.splits, result.capacity * sizeof(string_view));
            if (!tmp) {
                perror("realloc");
                free(result.splits);
                exit(EXIT_FAILURE);
            }
            result.splits = tmp;
        }
        result.splits[result.count].start = token_start;
        result.splits[result.count].len   = str + len - token_start;
        result.count++;
    }

    return result;
}

static void free_splits(string_splits *splits) {
    if (splits && splits->splits) {
        free(splits->splits);
        splits->splits   = NULL;
        splits->count    = 0;
        splits->capacity = 0;
    }
}
// static inline bool views_equal(string_view l, string_view r) {
//     if (l.len != r.len) return false;
//     return memcmp(l.start, r.start, l.len) == 0;
// }


#define STRING_VIEW_FROM_LITERAL(str) \
    (string_view) {.start=str,.len=sizeof(str)}
#endif /* STRINGOPS_H */
import sortables.*;

/**
 * Created by Nick on 2017-01-02.
 */
public final class ArraySortingDriver {
    private ArraySortingDriver() {}

    public static void main(String[] args) {
        System.out.println("Part 1: Sort from largest to smallest");
        int[] part1 = BoxOfThings.IntBoxOfThings();
        sort(makeAutoboxedIntegerCopy(part1), SortDescending.newInstance());

        System.out.println("Part 2: Sort from smallest to largest");
        int[] part2 = BoxOfThings.IntBoxOfThings();
        sort(makeAutoboxedIntegerCopy(part2), SortAscending.newInstance());

        System.out.println("Part 3: Sort from smallest to largest, leaving duplicates in");
        int[] part3 = BoxOfThings.IntBoxOfThingsWithDuplicates();
        sort(makeAutoboxedIntegerCopy(part3), SortAscending.newInstance());

        System.out.println("Part 4: Sort from largest to smallest in a new array with duplicates removed.");
        int[] part4 = BoxOfThings.IntBoxOfThingsWithDuplicates();
        sort(makeAutoboxedIntegerCopy(part4), SortDescending.newInstance(), RemoveDuplicates.newInstance());

        System.out.println("Part 5: Sort from longest word to shortest word");
        String[] part5 = BoxOfThings.StringBoxOfThings();
        sort(part5, SortLongestToShortestWord.newInstance());

        System.out.println("Part 6: Sort alphabetically a-z");
        String[] part6 = BoxOfThings.StringBoxOfThings();
        sort(part6, SortAlphabetically.newInstance());

        System.out.println("Part 7: Sort from longest word to shortest word (null is shorter than an empty string)");
        String[] part7 = BoxOfThings.StringBoxOfThingsWithNullsAndEmptyStringsAndDuplicates();
        sort(part7, SortLongestToShortestWord.newInstance());

        System.out.println("Part 8: Sort alphabetically a-z in a new array with duplicates, nulls, and empty strings removed.");
        String[] part8 = BoxOfThings.StringBoxOfThingsWithNullsAndEmptyStringsAndDuplicates();
        sort(part8, SortAlphabetically.newInstance(), RemoveDuplicates.newInstance(), RemoveNulls.newInstance(), RemoveEmpties.newInstance());
    }

    @SafeVarargs
    private static <E> void sort(E[] array, Sortable<E>... sortables) {
        new Sorter<>(array)
                .addSortables(sortables)
                .sort()
                .print();
    }

    // Thanks, Java!
    private static Integer[] makeAutoboxedIntegerCopy(int[] array) {
        Integer[] copy = new Integer[array.length];
        for (int i = 0; i < array.length; i++) {
            copy[i] = array[i];
        }

        return copy;
    }
}